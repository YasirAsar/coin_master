defmodule CoinMaster.Facebook.EventFixtures do
  @moduledoc false

  alias CoinMaster.Facebook.EventParser

  def get_started_event_fixtures do
    %{
      "entry" => [
        %{
          "id" => "123",
          "messaging" => [
            %{
              "postback" => %{
                "mid" => "1234",
                "payload" => "get_started",
                "title" => "Get Started"
              },
              "recipient" => %{"id" => "1234567"},
              "sender" => %{"id" => "1234567"},
              "timestamp" => 1_664_482_258_319
            }
          ],
          "time" => 1_664_482_258_706
        }
      ],
      "object" => "page"
    }
  end

  def greetings_event_fixtues do
    %{
      "entry" => [
        %{
          "id" => "123",
          "messaging" => [
            %{
              "message" => %{
                "mid" => "1234",
                "nlp" => %{
                  "detected_locales" => [
                    %{"confidence" => 0.5529, "locale" => "ta_IN"}
                  ],
                  "entities" => %{},
                  "intents" => [],
                  "traits" => %{
                    "wit$greetings" => [
                      %{
                        "confidence" => 0.9999,
                        "id" => "12345",
                        "value" => "true"
                      }
                    ],
                    "wit$sentiment" => [
                      %{
                        "confidence" => 0.7336,
                        "id" => "123456",
                        "value" => "positive"
                      }
                    ]
                  }
                },
                "text" => "hi"
              },
              "recipient" => %{"id" => "1234567"},
              "sender" => %{"id" => "1234567"},
              "timestamp" => 1_664_552_245_221
            }
          ],
          "time" => 1_664_552_245_675
        }
      ],
      "object" => "page"
    }
  end

  def search_event_fixtures do
    %{
      "entry" => [
        %{
          "id" => "123",
          "messaging" => [
            %{
              "message" => %{
                "mid" => "1234",
                "nlp" => %{
                  "detected_locales" => [
                    %{"confidence" => 0.7895, "locale" => "en_XX"}
                  ],
                  "entities" => %{},
                  "intents" => [],
                  "traits" => %{
                    "wit$sentiment" => [
                      %{
                        "confidence" => 0.5621,
                        "id" => "12345",
                        "value" => "neutral"
                      }
                    ]
                  }
                },
                "text" => "bitcoin"
              },
              "recipient" => %{"id" => "1234567"},
              "sender" => %{"id" => "1234567"},
              "timestamp" => 1_664_460_892_378
            }
          ],
          "time" => 1_664_460_893_131
        }
      ],
      "object" => "page"
    }
  end

  def quick_reply_event_fixtures do
    %{
      "entry" => [
        %{
          "id" => "123",
          "messaging" => [
            %{
              "message" => %{
                "mid" => "1234",
                "nlp" => %{
                  "detected_locales" => [
                    %{"confidence" => 0.7895, "locale" => "en_XX"}
                  ],
                  "entities" => %{},
                  "intents" => [],
                  "traits" => %{
                    "wit$sentiment" => [
                      %{
                        "confidence" => 0.5621,
                        "id" => "12345",
                        "value" => "neutral"
                      }
                    ]
                  }
                },
                "quick_reply" => %{"payload" => "bitcoin"},
                "text" => "Bitcoin"
              },
              "recipient" => %{"id" => "1234567"},
              "sender" => %{"id" => "1234567"},
              "timestamp" => 1_664_460_912_634
            }
          ],
          "time" => 1_664_460_913_736
        }
      ],
      "object" => "page"
    }
  end

  def get_started_event_message_fixtures do
    get_started_event_fixtures()
    |> EventParser.get_messaging()
    |> Map.get("postback")
  end

  def greetings_event_message_fixtues do
    greetings_event_fixtues()
    |> EventParser.get_messaging()
    |> get_in(["message", "text"])
  end

  def search_event_message_fixtures do
    search_event_fixtures()
    |> EventParser.get_messaging()
    |> get_in(["message", "text"])
  end

  def quick_reply_event_message_fixtures do
    quick_reply_event_fixtures()
    |> EventParser.get_messaging()
    |> get_in(["message", "quick_reply"])
  end
end
