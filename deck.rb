# Encoding: utf-8
require 'squib'
require 'csv'

CARD_DATA = {}

def bg(why)
  CARD_DATA[why]['Background']
end

def fg(why)
  CARD_DATA[why]['Foreground']
end

def bg_grad(whyl, whyr)
  '(0,0)(825,0) ' + bg(whyl) + '@0.2 ' + bg(whyr) + '@0.8'
end

def icon(why)
  CARD_DATA[why]['Icon'] + '.svg'
end

CSV.foreach('dynamic.csv', headers: true) do |row|
  CARD_DATA[row['Name']] = row
end

Squib::Deck.new(cards: 56, layout: 'layout.yml') do
  deck = csv file: 'cards.csv'
  attrl = deck['AttrL']
  attrr = deck['AttrR']
  colorl = attrl.map { |x| fg(x) }
  colorr = attrr.map { |x| fg(x) }
  background color: attrl.map.with_index { |x, i| bg_grad(x, attrr[i]) }
  text str: deck['Title'], layout: :CardTitle, color: colorl
  text str: attrl, layout: :FirstTitle, color: colorl
  text str: deck['ValueL'], layout: :FirstText, color: colorl
  text str: attrr, layout: :SecondTitle, color: colorr
  text str: deck['ValueR'], layout: :SecondText, color: colorr
  text str: deck['Quote'], layout: :QuoteText, color: colorr
  svg file: attrl.map { |x| icon(x) }, layout: :FirstIcon
  svg file: attrr.map { |x| icon(x) }, layout: :SecondIcon
  save_png prefix: 'cbat_'
  save_sheet prefix: 'cbat_multisheet_', columns: 4
  hand file: 'hand.png', trim: 0, trim_radius: 50, fill_color: '#0000'
end
