# Identicon

Built upon Ruby Matrix. Includes serveral renderers.

## Installation

Add this line to your application's Gemfile:

    gem 'identicon', github: 'max-power/identicon'
    
## Examples

### SVG
![Example2](http://id-con.herokuapp.com/MaMa.svg)
![Example3](http://id-con.herokuapp.com/Rupert.svg)
![Example4](http://id-con.herokuapp.com/Gina.svg)
![Example5](http://id-con.herokuapp.com/Matz.svg)
![Example6](http://id-con.herokuapp.com/Jane.svg)
![Example1](http://id-con.herokuapp.com/Sepp.svg)

### PNG
![Example2](http://id-con.herokuapp.com/MaMa.png?width=120)
![Example3](http://id-con.herokuapp.com/Rupert.png?width=120)
![Example4](http://id-con.herokuapp.com/Gina.png?width=120)
![Example5](http://id-con.herokuapp.com/Matz.png?width=120)
![Example6](http://id-con.herokuapp.com/Jane.png?width=120)
![Example1](http://id-con.herokuapp.com/Sepp.png?width=120)

## Usage

    require 'identicon/svg'

    Identicon('hi').to_svg
    
### Advanced Usage

    icon = Identicon.new(some_string, rows: 5, cols: 5)
    icon.digest
    icon.binary
    icon.matrix
    icon.color
    
    
### Render an Identicon
    
    icon.to_svg(options)
    icon.to_png(options)
    icon.to_html(options)
    icon.to_text(options)

#### Render Parameters

- `invert`:  Boolean - (default: false)
- `width`:   Integer - image width in Pixels (default: 240)
- `height`:  Integer - image height in Pixels (default: width)
- `padding: Float(0..1) - padding as Percentage of one Block width

## Contributing

1. Fork it ( http://github.com/max-power/identicon/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
