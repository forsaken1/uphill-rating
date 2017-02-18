defmodule UphillRating.ExAdmin.Dashboard do
  use ExAdmin.Register

  register_page "Dashboard" do
    menu priority: 1, label: "Dashboard"
    content do
      div ".blank_slate_container#dashboard_default_message" do
        span ".blank_slate" do
          span "Welcome to ExAdmin."

          div do
            span "This is the default dashboard page."
          end

          div do
            a "Add team", [href: "/admin/teams/new"]
          end

          div do
            a "Add bicyclist", [href: "/admin/bicyclists/new"]
          end

          div do
            a "Add race", [href: "/admin/races/new"]
          end

          div do
            a "Add result", [href: "/admin/bicyclist_races/new"]
          end
        end
      end
    end
  end
end
