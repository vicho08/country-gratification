# frozen_string_literal: true

class Country
  # Lista de países soportados
  LIST = {
    "Chile"    => "Chile",
    "México"   => "México",
    "Colombia" => "Colombia"
    # Agrega aquí más países según los vayas soportando
  }.freeze

  # Devuelve un array para usar en select, ej: [["Chile", "Chile"], ["México", "México"]]
  def self.all
    LIST.map { |key, value| [value, key] }
  end

  # Para validar o buscar si es un país válido
  def self.valid?(name)
    LIST.key?(name)
  end

  # Puedes agregar métodos para mostrar banderas, etiquetas, etc.
end
