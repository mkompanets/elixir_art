defmodule ElixirArt do
  import Mogrify

  def draw_circle(image, origin_x, origin_y, radius) do
    image
    |> custom("draw", "translate #{to_string(:io_lib.format("~g,~g ~s ~g,~g ~g,~g", [origin_x/1, origin_y/1, "circle", 0/1, 0/1, radius/1, 0/1]))}")
  end

  def draw_rectangle(image, upper_left_x, upper_left_y, lower_right_x, lower_right_y) do
    image
    |> custom("draw", "rectangle #{to_string(:io_lib.format("~g,~g ~g,~g", [upper_left_x/1, upper_left_y/1, lower_right_x/1, lower_right_y/1]))}")
  end

  def create_test do
    %Mogrify.Image{path: "test1.png", ext: "png"}
    |> custom("size", "480x480")
    |> canvas("white")
    |> custom("fill", "green")
    |> draw_rectangle(110,400,10,10)
    |> custom("fill", "green")
    |> draw_circle(200,200,50)
    |> create(path: ".")
  end
end
