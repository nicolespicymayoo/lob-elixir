defmodule Lob.Helpers do
  @moduledoc """
  Helper functions for transfroming a map into format acceptable for HTTPoision
  for form POST.
  """

  def transform(map, parent \\"") do
      try do
        form =
          map
          |> Enum.map(&(transform_item(&1, parent)))
          |> List.flatten
        form_type = Enum.any?(form, &(elem(&1,0) == :file)) && :multipart || :form
        {:ok, {form_type, form}}
      rescue
         _ -> {:error, "failed to transform data"}
      end
  end

  defp transform_item({_, %{path: path, name: name}}, _) do
    file_name = "\"" <> path <> "\""
    extra = {["form-data"], [name: name, filename: file_name]}
    {:file, path, extra, []}
  end
  defp transform_item({k, %{content: content}}, "") do
      {to_string(k), content}
  end
  defp transform_item({k, %{url: url}}, "") do
      {to_string(k), url}
  end
  defp transform_item({k,v}, _) when is_map(v) do
    {:ok, {_type, form}} = transform(v, to_string(k))
    Enum.reverse(form)
  end

  defp transform_item({k, v}, "") when is_atom(v) do
    {to_string(k), to_string(v)}
  end

  defp transform_item({k, v}, "") when is_list(v) do
    Enum.map(v, fn value -> {to_string(k) <> "[]", value} end)
  end
  
  defp transform_item({k,v}, "") do
    {to_string(k), to_string(v)}
  end
  defp transform_item({k,v}, parent) do
    {parent <> "[" <> to_string(k) <> "]", v}
  end


  # Encodes the given map or list of tuples.
  # used to encode query params 
  
  def encode_data(kv, encoder \\ &to_string/1) do
   IO.iodata_to_binary encode_pair("", kv, encoder)
  end

  # covers structs
  defp encode_pair(field, %{__struct__: struct} = map, encoder) when is_atom(struct) do
   [field, ?=|encode_value(map, encoder)]
  end

  # covers maps
  defp encode_pair(parent_field, %{} = map, encoder) do
   encode_kv(map, parent_field, encoder)
  end

  # covers keyword lists
  defp encode_pair(parent_field, list, encoder) when is_list(list) and is_tuple(hd(list)) do
   encode_kv(Enum.uniq_by(list, &elem(&1, 0)), parent_field, encoder)
  end

  # covers non-keyword lists
  defp encode_pair(parent_field, list, encoder) when is_list(list) do
   prune Enum.flat_map list, fn value ->
     [?&, encode_pair(parent_field <> "[]", value, encoder)]
   end
  end

  # covers nil
  defp encode_pair(field, nil, _encoder) do
   [field, ?=]
  end

  # encoder fallback
  defp encode_pair(field, value, encoder) do
   [field, ?=|encode_value(value, encoder)]
  end

  defp encode_kv(kv, parent_field, encoder) do
   prune Enum.flat_map kv, fn
     {_, value} when value in [%{}, []] ->
       []
     {field, value} ->
       field =
         if parent_field == "" do
           encode_key(field)
         else
           parent_field <> "[" <> encode_key(field) <> "]"
         end
       [?&, encode_pair(field, value, encoder)]
   end
  end

  defp encode_key(item) do
   item |> to_string |> URI.encode_www_form
  end


  defp encode_value(item, encoder) do
    item |> encoder.() |> URI.encode_www_form
  end

  defp prune([?&|t]), do: t
  defp prune([]), do: []

end