require_relative 'control'
require_relative 'interface'

interface = Interface.new
Control.new(interface).begin
