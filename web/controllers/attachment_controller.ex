defmodule Rumbl.AttachmentController do
  use Rumbl.Web, :controller

  alias Rumbl.Attachment

  def create(conn, %{"attachment" => attachment_params}) do
    changeset = Attachment.changeset(%Attachment{}, attachment_params)

    case Repo.insert(changeset) do
      {:ok, attachment} ->
        render(conn, "attachment.json", attachment: attachment)
      {:error, changeset} ->
        {:reply, {:error, %{errors: changeset}}}
    end
  end

  def delete(conn, %{"id" => id}) do
    attachment = Repo.get!(Attachment, id)
    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(attachment)

    # Unforutnaly this does not work :(
    #
    # attachment = Repo.get Attachment, id
    # path = Rumbl.Image.url({attachment.file, attachment})
    # Rumbl.Image.delete({path, attachment})
    #
    # Since the above deletion doesn't really need to happen synchronously, you can delete it asynchronously to speed up the request/response.
    # spawn(fn -> Rumbl.Image.delete({path, attachment}) end)

    path = Rumbl.Image.url({attachment.file, attachment})
    Rumbl.Image.delete({path, attachment})

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(201, "")
  end
end
