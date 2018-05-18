module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

type Msg =
    SaveAddress String
    | SavePassword String

type alias Model =
    { emailAddress : String
    , password : String
    }

init : ( { emailAddress : String, password : String }, Cmd msg )
init =
    ({ emailAddress = ""
    , password = ""
    }
    , Cmd.none)

update : Msg -> { a | emailAddress : String, password : String } -> ( { a | emailAddress : String, password : String }, Cmd msg )
update message model = 
    case message of
        SaveAddress address ->
            ({ model | emailAddress = address }
            , Cmd.none)
        SavePassword password ->
            ({ model | password = password }
            , Cmd.none)
        

header : Html msg
header =
    h1 [] [ text "Elm DOJO!!!" ]


body : Model -> Html Msg
body model =
    div []
        [ div []
            [ input [ placeholder "Email", type_ "email", required True, onInput SaveAddress, value model.emailAddress ] []
            ]
        , div []
            [ input [ placeholder "password", type_ "password", required True, value model.password ] []
            ]
        ]


footer : Html msg
footer =
    div []
        [ button [] [ text "Signin" ]
        ]


view : Model -> Html Msg
view model =
    Html.form []
        [ header
        , body model
        , footer
        ]

main : Program Never { emailAddress : String, password : String } Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
