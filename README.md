# Calculadora de Gratificación Legal

Calculadora web en Ruby on Rails para estimar la gratificación (bono legal) de empleados en **Chile, México y Colombia**, según las fórmulas laborales de cada país.

---

## 📋 Descripción

Esta aplicación permite calcular la gratificación correspondiente a un trabajador de acuerdo a su país.  
El formulario es dinámico: los campos requeridos cambian según el país seleccionado.  
El cálculo y las validaciones están desacopladas y organizadas por estrategias específicas por país (Patrón Strategy).

- **No requiere base de datos**.
- Implementada con ActiveModel y formularios Rails puros.
- Validaciones y mensajes de error en español.
- Fácil de extender para nuevos países o fórmulas.

---

## 🚀 Instalación y Ejecución

1. **Clona el repositorio**
   ```bash
   git clone https://github.com/vicho08/country-gratification.git
   cd country-gratificacion
    ```

2. **Instala las dependencias**

   ```bash
   bundle install
   ```  

3. **Inicia el servidor Rails**

   ```bash
   rails s
   ```

4. **Abre la aplicación en tu navegador**

   ```
   http://localhost:3000
   ```

---

## 📝 Uso

* Selecciona un país en el formulario.
* Ingresa los datos requeridos para ese país.
* Haz clic en “Calcular”.
* Verás el resultado de la gratificación o los mensajes de error si falta información.

---

## 🧩 Estructura del proyecto

```
app/
  models/
    gratification.rb
    country.rb
    gratifications/
      base_gratification.rb
      chile_gratification.rb
      mexico_gratification.rb
      colombia_gratification.rb
  controllers/
    gratifications_controller.rb
  views/
    gratifications/
      new.html.erb
```

---

## 🛠️ Tests

Para correr los tests:

```bash
bundle exec rspec
```

Para ver cobertura de código: reporte en `coverage/index.html`.

---

## ➕ Extender la app

Para agregar un nuevo país:

1. Agrega la estrategia en `app/models/gratifications/`.
2. Añade la opción en `Country::LIST` y el locale en `es.yml`.
3. Implementa la lógica y las validaciones necesarias.
4. ¡Listo!

---

## 👤 Autor

* Vicente Illanes

---

