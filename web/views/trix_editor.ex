defmodule Rumbl.TrixEditorHelpers do
  use Phoenix.HTML

  def trix_editor(form, field, opts \\ []) do
    trix_opts =
      opts
      |> Keyword.put_new(:input, Phoenix.HTML.Form.field_id(form, field))

    input_opts =
      opts
      |> Keyword.put_new(:id, Phoenix.HTML.Form.field_id(form, field))
      |> Keyword.put_new(:name, Phoenix.HTML.Form.field_name(form, field))
      |> Keyword.put_new(:type, "hidden")

    input_type = Phoenix.HTML.Form.input_type(form, field)

    {value, opts} = Keyword.pop(opts, :value, Phoenix.HTML.Form.field_value(form, field) || "")

    trix = content_tag(:"trix-editor", html_escape(["\n", value]), trix_opts)

    input = apply(Phoenix.HTML.Form, input_type, [form, field, input_opts])

    [input, trix || ""]
  end
end
