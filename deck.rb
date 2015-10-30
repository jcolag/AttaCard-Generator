# Encoding: utf-8
require 'squib'
require 'csv'

# Utility class to store information about cards in general
class CardData
  @card_data = nil

  def initialize(file)
    @card_data = {}
    CSV.foreach(file, headers: true) do |row|
      @card_data[row['Name']] = row
    end
  end

  def bg(why)
    @card_data[why]['Background']
  end

  def fg(why)
    @card_data[why]['Foreground']
  end

  def icon(why)
    @card_data[why]['Icon'] + '.svg'
  end

  def grad(whyl, whyr)
    '(0,0)(825,0) ' + bg(whyl) + '@0.2 ' + bg(whyr) + '@0.8'
  end
end

cards = CardData.new('dynamic.csv')
Squib::Deck.new(cards: 56, layout: 'layout.yml') do
  deck = csv file: 'cards.csv'
  attrl = deck['AttrL']
  attrr = deck['AttrR']
  colorl = attrl.map { |x| cards.fg(x) }
  colorr = attrr.map { |x| cards.fg(x) }
  background color: attrl.map.with_index { |x, i| cards.grad(x, attrr[i]) }
  text str: deck['Title'], layout: :CardTitle, color: colorl
  text str: attrl, layout: :FirstTitle, color: colorl
  text str: deck['ValueL'], layout: :FirstText, color: colorl
  text str: attrr, layout: :SecondTitle, color: colorr
  text str: deck['ValueR'], layout: :SecondText, color: colorr
  text str: deck['Quote'], layout: :QuoteText, color: colorr
  svg file: attrl.map { |x| cards.icon(x) }, layout: :FirstIcon
  svg file: attrr.map { |x| cards.icon(x) }, layout: :SecondIcon
  save_png prefix: 'cbat_'
  save_sheet prefix: 'cbat_multisheet_', columns: 4
  hand file: 'hand.png', trim: 0, trim_radius: 50, fill_color: '#0000'
end
