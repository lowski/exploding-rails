Factory =
  ROM::Factory
    .configure { |config| config.rom = ROM.env }
    .struct_namespace(Entities)

Dir[Rails.root.join('spec', 'factories', '**', '*.rb')].sort.each { |f| require f }
