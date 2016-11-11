defmodule ContactDemo.Factory do
  use ExMachina.Ecto, repo: ContactDemo.Repo

  alias ContactDemo.{User, Category}

  def user_factory do
    %User{
      name: sequence(:first_name, &"First #{&1}"),
      username: sequence(:last_name, &"Last #{&1}"),
      email: sequence(:email, &"email-#{&1}@foo.com"),
      encrypted_password: "changeme",
      password: "changeme",
      password_confirmation: "changeme"
    }
  end

  def category_factory do
    %Category{
      name: sequence(:name, &"Name #{&1}"),
      position: 42
    }
  end

  # def board_with_lists_factory do
  #   %Board{
  #     name: sequence(:name, &"Name #{&1}"),
  #     user: build(:user),
  #     lists: build_list(3, :list)
  #   }
  # end
  #
  # def list_factory do
  #   %List{
  #     name: sequence(:name, &"Name #{&1}")
  #   }
  # end
  #
  # def card_factory do
  #   %Card{
  #     name: sequence(:name, &"Name #{&1}")
  #   }
  # end
  #
  # def list_with_cards_factory do
  #   %List{
  #     name: sequence(:name, &"Name #{&1}"),
  #     board: build(:board),
  #     cards: build_list(5, :card)
  #   }
  # end
  #
  # def comment_factory do
  #   %Comment{
  #     user: build(:user),
  #     card: build(:card),
  #     text: sequence(:name, &"Some Text #{&1}")
  #   }
  # end
end
