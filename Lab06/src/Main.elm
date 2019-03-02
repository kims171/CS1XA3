import Browser
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (value, placeholder)
import Html.Events exposing (onInput)

main = Browser.sandbox { init = init, update = update, view = view }




-- Model 

type alias Model = 
    {
    string1 : String,
    string2 : String
    }

type Msg = Text1 String
    | Text2 String 

init : Model
init = Model "" "" 



-- View 

view : Model -> Html Msg
view model = div []
    [ input [placeholder "String 1", value model.string1, onInput Text1 ] []
    , input [placeholder "String 2", value model.string2, onInput Text2 ] []
    , div [] [ text (model.string1 ++ " : " ++ model.string2) ]
    ]



-- Update

update : Msg -> Model -> Model
update msg model = case msg of
    Text1 newText1 -> {model | string1 = newText1}
    Text2 newText2 -> {model | string2 = newText2}    
