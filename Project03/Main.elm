module Main exposing (main)

import Array
import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as EventsE
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Html.Events as Events
import List.Extra
import Matrix exposing (Matrix)
import Random
import Json.Encode as JEncode
import Json.Decode as JDecode
import Http


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


-- Lonnie Kim project 03 Source Code

-- MODEL


type GameState
    = Setup
    | Playing
    | Won


type alias Board =
    Matrix Bool


type alias Model =
    { gameState : GameState
    , board : Board
    , numSeedMoves : Int
    , numMovesMade : Int
    }


initialBoard : Board
initialBoard =
    Matrix.repeat 5 5 False


initialModel : Model
initialModel =
    { gameState = Setup
    , board = initialBoard
    , numSeedMoves = 0
    , numMovesMade = 0
    }


init : () -> ( Model, Cmd Msg )
init flags =
    ( initialModel, Cmd.none )



-- UPDATE


type Msg
    = ToggleLight Int Int
    | NewGame
    | SeedBoard (List ( Int, Int ))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleLight toggleX toggleY ->
            case model.gameState of
                Playing ->
                    let
                        board =
                            toggleLight ( toggleX, toggleY ) model.board
                    in
                    ( { model
                        | board = board
                        , gameState = getGameState board
                        , numMovesMade = model.numMovesMade + 1
                      }
                    , Cmd.none
                    )

                _ ->
                    ( model, Cmd.none )

        SeedBoard coordList ->
            ( { model
                | board = toggleLights coordList model.board
                , gameState = Playing
                , numSeedMoves = List.length coordList
              }
            , Cmd.none
            )

        NewGame ->
            ( { model
                | gameState = Setup
                , board = initialBoard
                , numMovesMade = 0
                , numSeedMoves = 0
              }
            , Random.generate SeedBoard (coordListGenerator model.board)
            )


getGameState : Board -> GameState
getGameState board =
    if isBoardWon board then
        Won
    else
        Playing


isBoardWon : Board -> Bool
isBoardWon board =
    board == initialBoard


toggleLight : ( Int, Int ) -> Board -> Board
toggleLight ( toggleX, toggleY ) =
    Matrix.indexedMap
        (\lightX lightY isOn ->
            if lightX == toggleX && lightY == toggleY then
                not isOn

            else if lightX == toggleX && lightY == toggleY - 1 then
                not isOn

            else if lightX == toggleX && lightY == toggleY + 1 then
                not isOn

            else if lightX == toggleX - 1 && lightY == toggleY then
                not isOn

            else if lightX == toggleX + 1 && lightY == toggleY then
                not isOn

            else
                isOn
        )


toggleLights : List ( Int, Int ) -> Board -> Board
toggleLights coordList board =
    coordList
        |> List.foldl toggleLight board


coordListGenerator : Matrix a -> Random.Generator (List ( Int, Int ))
coordListGenerator matrix =
    let
        ( width, height ) =
            ( Matrix.width matrix, Matrix.height matrix )

        ( maxX, maxY ) =
            ( width - 1, height - 1 )

        maxCount =
            width * height
    in
    Random.int 5 maxCount
        |> Random.andThen (\len -> Random.list len (coordGenerator maxX maxY))
        |> Random.map List.Extra.unique


coordGenerator : Int -> Int -> Random.Generator ( Int, Int )
coordGenerator maxX maxY =
    Random.pair (Random.int 0 maxX) (Random.int 0 maxY)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

-- VIEW

view : Model -> Html Msg
view model =
    gameBoard model
        |> Element.layout
            [ Background.color darkGray
            , Font.color lightSkyBlue
            , Font.size 16
            , Font.family
                [ Font.typeface "Courier"
                , Font.monospace
                ]
            ]

gameBoard : Model -> Element Msg
gameBoard model =
    model.board
        |> rows
        |> List.indexedMap lightButtonRow
        |> column
            [ centerX
            , centerY
            , spacing 8
            , paddingXY 32 0
            , onLeft <| sidebar model
            , onRight <| winText model
            ]


sidebar : Model -> Element Msg
sidebar model =
    column
        [ height fill, spacing 8 ]
        [ el [ Font.size 40 ] <| text "Lights Off"
        , Input.button
            [ centerY, Font.size 24, mouseOver [ Font.glow lightSkyBlue 0.5 ] ]
            { onPress = Just NewGame, label = text "New Game!" }
        , stats model
        , credits
        ]


credits : Element Msg
credits =
    column [ alignBottom ]
        [ link []
            { url = "https://github.com/kims171/CS1XA3/tree/master/Project03" --link to my github
            , label = text "Link to Source Code"
            }
        ]


winText : Model -> Element Msg
winText model =
    column [ spacing 32 ]
        [ case model.gameState of
            Won ->
                text "Game Complete! Well Done"

            _ ->
                none
        ]

stats : Model -> Element Msg
stats model =
    column
        [ centerY, spacing 8 ]
        [ text <| "moves:" ++ String.fromInt model.numMovesMade
        , text <| "goal:" ++ String.fromInt model.numSeedMoves
        ]


rows : Matrix a -> List (List a)
rows matrix =
    List.range 0 (Matrix.height matrix - 1)
        |> List.map (\y -> Matrix.getRow y matrix)
        |> List.map (Result.withDefault Array.empty)
        |> List.map Array.toList



lightButtonRow : Int -> List Bool -> Element Msg
lightButtonRow y =
    List.indexedMap (lightButton y) >> row [ centerX, spacing 8 ]


lightButton : Int -> Int -> Bool -> Element Msg
lightButton y x isOn =
    el
        [ Background.color <| lightColor isOn
        , width <| px 100
        , height <| px 100
        , EventsE.onClick <| ToggleLight x y
        , Border.rounded 10
        ]
        none

lightColor : Bool -> Color
lightColor isOn =
    if isOn then
        lightSkyBlue
    else
        midnightBlue


-- COLORS USED

darkGray : Color
darkGray =
    rgb255 38 38 38

lightGray : Color
lightGray =
    rgb255 188 188 188

lightSkyBlue : Color
lightSkyBlue =
    rgb255 135 206 250

midnightBlue : Color
midnightBlue =
    rgb255 25 25 112
