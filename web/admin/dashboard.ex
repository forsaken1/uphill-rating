defmodule UphillRating.ExAdmin.Dashboard do
  use ExAdmin.Register

  register_page "Dashboard" do
    menu priority: 1, label: "Dashboard"
    content do
      div ".blank_slate_container#dashboard_default_message" do
        span ".blank_slate" do
          div do
            span "Добро пожаловать в панель управления проекта Uphill rating."
          end

          br()

          div do
            span "Краткая инструкция по работе:"
          end

          div do
            span "Для удобства рекомендуется добавлять данные в следующем порядке: команда, велосипедист (привязывается к команде), гонка, результат (привязывается к гонке, велосипедисту и команде)"
          end

          div do
            span "Результат имеет привязку к команде для того, чтобы велосипедист мог выступать за разные команды в разных гонках."
          end

          br()

          div do
            span "Импорт данных:"
          end

          div do
            span "Доступен для велосипедистов и результатов (находятся справа в блоке 'Import' в соответствующих разделах)."
          end

          div do
            span "Используется файл в формате CSV (comma separated value) - каждая сущность находится в отдельной строке, данные сущности разделены ';'. Имя велосипедиста, название гонки и команды необходимо указывать точно так, как они называются в системе, соблюдая регистр символов и не добавляя лишних пробелов. Пол: Male/Female."
          end

          div do
            span "Формат строк для импорта велосипедистов: 'Иван Иванов;1991;Male;XC TRAINING'"
          end

          div do
            span "Формат строк для импорта результатов: '00:06:14.2;Иван Иванов;Сабанеева;XC TRAINING'"
          end

          br()

          div do
            span "После импорта результатов необходимо пересчитать очки для конкретной гонки, сделать это можно в подробном просмотре гонки, слева кнопка 'Calculate'"
          end

          div do
            span "При ручном заполнении результатов пересчет осуществляется автоматически"
          end

          br()

          div do
            a "Добавить команду", [href: "/admin/teams/new"]
          end

          div do
            a "Добавить велосипедиста", [href: "/admin/bicyclists/new"]
          end

          div do
            a "Добавить гонку", [href: "/admin/races/new"]
          end

          div do
            a "Добавить результат", [href: "/admin/bicyclist_races/new"]
          end
        end
      end
    end
  end
end
