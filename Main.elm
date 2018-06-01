module Main exposing (main)

import Css exposing (..)
import Css.Colors exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, placeholder, type_, value)
import Html.Styled.Events exposing (onInput, onSubmit)


required_ =
    Html.Styled.Attributes.required


type Msg
    = SaveAddress String
    | SavePassword String
    | SubmitForm


type alias Model =
    { emailAddress : String
    , password : String
    , loading : Bool
    }


init : ( Model, Cmd msg )
init =
    ( { emailAddress = "guil@gui.com"
      , password = "123"
      , loading = False
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd msg )
update message model =
    case message of
        SaveAddress address ->
            ( { model | emailAddress = address }
            , Cmd.none
            )

        SavePassword password ->
            ( { model | password = password }
            , Cmd.none
            )

        SubmitForm ->
            ( { model | loading = True }, Cmd.none )


header : Html msg
header =
    h1 [] [ text "Elm DOJO!!!" ]


styledInput : List (Attribute msg) -> List (Html msg) -> Html msg
styledInput =
    styled input
        [ border (px 0)
        , borderBottom3 (px 1) solid (hex "#ccc")
        , outline none
        , hover
            [ borderBottomColor purple
            ]
        ]


body : Model -> Html Msg
body model =
    div []
        [ div []
            [ styledInput [ placeholder "Email", type_ "email", required_ True, onInput SaveAddress, value model.emailAddress ] []
            ]
        , div []
            [ styledInput [ placeholder "password", type_ "password", required_ True, value model.password ] []
            ]
        ]


styledButton : List (Attribute msg) -> List (Html msg) -> Html msg
styledButton =
    styled button
        [ padding (px 10)
        , backgroundColor blue
        , color white
        , fontSize (Css.rem 1.5)
        , borderRadius (px 20)
        ]


footer : Model -> Html msg
footer model =
    let
        showLoading =
            if model.loading then
                span [] [ text "Carregando..." ]
            else
                span [] []
    in
        div []
            [ styledButton
                []
                [ text "Signin" ]
            , showLoading
            ]


view : Model -> Html Msg
view model =
    Html.Styled.form [ onSubmit SubmitForm ]
        [ header
        , body model
        , footer model
        ]


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
