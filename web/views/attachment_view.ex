defmodule Rumbl.AttachmentView do
  use Rumbl.Web, :view

  def render("attachment.json", %{attachment: attachment}) do
    %{
      id: attachment.id,
      url: Rumbl.Image.url({attachment.file, attachment})
    }
  end
end
