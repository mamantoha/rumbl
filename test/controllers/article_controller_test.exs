defmodule Rumbl.ArticleControllerTest do
  use Rumbl.ConnCase

  alias Rumbl.Article

  setup do
    user = insert(:user)
    conn = assign(build_conn(), :current_user, user)
    {:ok, conn: conn, user: user}
  end

  @valid_attrs %{body: "some content", title: "some content"}
  @invalid_attrs %{body: "", title: ""}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, article_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing articles"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, article_path(conn, :new)
    assert html_response(conn, 200) =~ "New article"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, article_path(conn, :create), article: @valid_attrs
    assert redirected_to(conn) == article_path(conn, :index)
    assert Repo.get_by(Article, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, article_path(conn, :create), article: @invalid_attrs
    assert html_response(conn, 200) =~ "New article"
  end

  test "shows chosen resource", %{conn: conn, user: user} do
    article = insert(:article, user: user)
    conn = get conn, article_path(conn, :show, article)
    assert html_response(conn, 200) =~ "Show article"
  end

  test "renders page not found when id is nonexistent", %{conn: conn, user: user} do
    assert_error_sent 404, fn ->
      get conn, article_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn, user: user} do
    article = insert(:article, user: user)
    conn = get conn, article_path(conn, :edit, article)
    assert html_response(conn, 200) =~ "Edit article"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn, user: user} do
    article = insert(:article, user: user)
    conn = put conn, article_path(conn, :update, article), article: @valid_attrs
    assert redirected_to(conn) == article_path(conn, :show, article)
    assert Repo.get_by(Article, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn, user: user} do
    article = insert(:article, user: user)
    conn = put conn, article_path(conn, :update, article), article: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit article"
  end

  test "deletes chosen resource", %{conn: conn, user: user} do
    article = insert(:article, user: user)
    conn = delete conn, article_path(conn, :delete, article)
    assert redirected_to(conn) == article_path(conn, :index)
    refute Repo.get(Article, article.id)
  end
end
