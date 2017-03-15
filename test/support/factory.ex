defmodule Rumbl.Factory do
  use ExMachina.Ecto, repo: Rumbl.Repo

  def user_factory do
    %Rumbl.User{
      name: sequence(:name, &"User #{&1}"),
      username: sequence(:username, &"user-#{&1}")
    }
  end

  def video_factory do
    %Rumbl.Video{
      user: build(:user),
      category: build(:category),
    }
  end

  def article_factory do
    %Rumbl.Article{
      title: sequence(:title, &"Title #{&1}"),
      body: sequence(:body, &"Body #{&1}"),
      user: build(:user),
    }
  end

  def category_factory do
    %Rumbl.Category{
      name: sequence(:name, &"User #{&1}"),
    }
  end

end
