defmodule ElixirArt.Hypnotoad do
  import Mogrify
  import ElixirArt, only: [draw_circle: 4, draw_rectangle: 5]

  # DIMENTIONS
  @border_square 15
  @outer_circle 30
  @inner_circle 21
  @base_square 100
  @width (3000 + @border_square)
  @height (1000 + @border_square)
  @circle_offset  ((@base_square - @border_square) / 2)

  @canvas_color "#F0EAD6"

  # ElixirArt.Hypnotoad.create will create a single image
  def create do
    # initialize the image
    img = %Mogrify.Image{path: "hypnotoad.png", ext: "png"}
    |> custom("size", "#{@width}x#{@height}")
    |> canvas(@canvas_color)

    coordinates()
    |> Enum.reduce(img, fn({x, y}, acc) ->
      [c1, c2, c3] = colors() |> Enum.random |> Enum.shuffle

      acc
      |> custom("fill", c1)
      |> draw_rectangle(x, y, x + @base_square - @border_square, y + @base_square - @border_square)

      |> custom("fill", c2)
      |> draw_circle(x + @circle_offset, y + @circle_offset, @outer_circle)

      |> custom("fill", c3)
      |> draw_circle(x + @circle_offset, y + @circle_offset, @inner_circle - :rand.uniform(10))
    end)
    |> create(path: ".")
  end

  def create_gif do
    # set the colors to be consistent and only vary the inner radius
    colors_and_coordinates = coordinates()
                            |> Enum.map(fn(coord) ->
                              color_selection = more_colors() |> Enum.random |> Enum.shuffle
                              {coord, color_selection}
                            end)

    (1..12) |> Enum.each(fn(n) ->
      # initialize the image
      img = %Mogrify.Image{path: "hypnotoad#{n}.png", ext: "png"}
      |> custom("size", "#{@width}x#{@height}")
      |> canvas(@canvas_color)

      colors_and_coordinates
      |> Enum.reduce(img, fn({{x, y}, color}, acc) ->
        [c1, c2, c3] = color

        acc
        |> custom("fill", c1)
        |> draw_rectangle(x, y, x + @base_square - @border_square, y + @base_square - @border_square)

        |> custom("fill", c2)
        |> draw_circle(x + @circle_offset, y + @circle_offset, @outer_circle)

        |> custom("fill", c3)
        |> draw_circle(x + @circle_offset, y + @circle_offset, @inner_circle - :rand.uniform(11))
      end)
      |> create(path: ".")
    end)

    # run this on the command line
    #convert -delay 15 -dispose None \
    #              -page 3015x1015 hypnotoad1.png  \
    #              -page +0+0 hypnotoad2.png  \
    #              -page +0+0 hypnotoad3.png  \
    #              -page +0+0 hypnotoad4.png  \
    #              -page +0+0 hypnotoad5.png  \
    #              -page +0+0 hypnotoad6.png  \
    #              -page +0+0 hypnotoad7.png  \
    #              -page +0+0 hypnotoad8.png  \
    #              -page +0+0 hypnotoad9.png  \
    #              -page +0+0 hypnotoad10.png  \
    #              -page +0+0 hypnotoad11.png  \
    #              -page +0+0 hypnotoad12.png  \
    #              -loop 0  hypnotoad.gif
  end

  defp coordinates do
    # calculate the number of horizontal and vertical squares based on dimentions
    horizontal_squares = ((@width / @base_square) - 1) |> round
    vertical_squares = ((@height / @base_square) - 1) |> round

    # create the matrix of coordinates based on square dimentions
    rows = (0..vertical_squares) |> Enum.map(&((&1 * @base_square) + @border_square))
    columns = (0..horizontal_squares) |> Enum.map(&((&1 * @base_square) + @border_square))

    rows |> Enum.map(fn(row) ->
      columns |> Enum.map(fn(col) -> {col, row} end)
    end)
    |> List.flatten
  end

  defp colors do
    # could always add more colors...later
    [
      ["#338A2E", "#89DE85", "#175C13"]
    ]
  end

  defp more_colors do
    [
      ["#338A2E", "#89DE85", "#175C13"],
      ["#316314", "#83C65C", "#AEE98B"],
      ["#E8F995", "#C7DB66", "#91A437"],
      ["#C374C3", "#934493", "#4A0F4A"],
      ["#F190A7", "#D0617B", "#9C344C"],
    ]
  end

end
