// VARIABLES GLOBALES

let id_usuario_logueado = 0; // ID DEL USUARIO CUANDO SE REGISTRA
let id_hotel_seleccionado; // ID DEL HOTEL SELECCIONADO

function fMostrarFormularios(nombre_formulario_con_almohadilla) {
    //Guardamos todos los formularios en una lista de formularios con el querySelectorAll
    let lista_formularios = document.querySelectorAll("#div_formularios div");
    //Ocultamos primero todos los formularios internos del div_formularios
    lista_formularios.forEach(item => {
        item.style.display = 'none';
    });
    //Mostramos el formulario quq queramos dentro de la modal
    document.querySelector(nombre_formulario_con_almohadilla).style.display = "flex";
    // Mostramos la modal
    document.querySelector("#div_formularios").style.display = "flex";

}

function fMostrarModal(nombre_modal_con_almohadilla) {

    console.log(nombre_modal_con_almohadilla);
    
    
    // OCULTAMOS TODOS LOS DIV (ESTOS VAN A SER TODOS MODALES) -> LOS GUARDAMOS EN UNA LISTA

    let lista_modales =  document.querySelectorAll("section > div");


    lista_modales.forEach(item => {
        item.style.display = "none";
        console.log(item)
    });

    document.querySelector(nombre_modal_con_almohadilla).style.display = "flex";
}


// Muestra la modal principal de preparar viaje (donde eliges la ciudad primero)

function fMostrarPrepararViaje(){
    // Declaramos 2 array list para el finally
    let lista_ciudades = [];
    let lista_fotos = [];
    // Hacemos la peticion de 6 ciudades aleatorias
    let sql = "SELECT ciu_nombre, ciu_foto FROM ciudades ORDER BY rand() LIMIT 6;";
    let URL = "assets/php/servidor.php?peticion=EjecutarSelect";
    URL += "&sql=" + sql;
    fetch(URL)
    .then((response) => response.json())
    .then((data) => {
        let html = "";
        console.log("Ciudades: ", data)
        data.datos.forEach(item => {
            // Reemplazamos los espacios en el nombre de la ciudad por guiones bajos, los ids no aceptan espacios
            let ciudadId = item.ciu_nombre.replace(/\s+/g, '_');
            lista_ciudades.push(ciudadId);
            lista_fotos.push(item.ciu_foto);
            html += "<div class='ciudades'>"
            html += `    <div id='${ciudadId}'>`
            html += `       ${item.ciu_nombre}`
            html += "    </div>"
            html += "</div>"
        });
        // Las imprimimos dentro de #pv_ciudades
        document.querySelector("#pv_ciudades").innerHTML = html;
        fMostrarModal("#modal_preparar_viaje");
    })
    .finally(() => {
        lista_ciudades.forEach((item, indice) => {
            document.querySelector(`#${item}`).style.backgroundImage = `url(../project/assets/imagenes/ciudades/${lista_fotos[indice]})`;
            document.querySelector(`#${item}`).style.backgroundSize = "cover";
        });
    });
} 
// Boton de registrar, hace un insert a usuarios

function fRegistrar(){

    // Lectura de todas las variables

    let nombre = document.querySelector("#nombre_registro").value;
    let apellidos = document.querySelector("#apellidos_registro").value;
    let alias = document.querySelector("#alias_registro").value;
    let password = document.querySelector("#password_registro").value;
    let passwordR = document.querySelector("#password_registro_r").value;
    let documento = document.querySelector("#nif_registro").value;
    let telefono = document.querySelector("#telefono_registro").value;
    let fnac = document.querySelector("#fnac_registro").value;

    if (password != passwordR) {
        document.querySelector("#div_error_registro").style.display = 'flex';
        document.querySelector("#div_error_registro").innerHTML = 'Las contraseñas no coinciden, por favor pruebe de nuevo.';        
        return;
    }

    // Si coinciden, se sigue ejecutando y enviamos los datos a servidor

    let sql = `call usuarios_insert('${nombre}','${apellidos}','${alias}','${password}','${documento}','${telefono}','${fnac}')`;
    const URL = "assets/php/servidor.php?peticion=EjecutarInsert&sql=" + sql;

    //Debemos de pedirsela al servidor
            
        fetch(URL)
        .then((response) => response.json())
        .then((data) => {
  
          
      })
      
      .finally(()=>{

        // Vaciamos todo
        document.querySelector("#nombre_registro").value = "";
        document.querySelector("#apellidos_registro").value = "";
        document.querySelector("#alias_registro").value = "";
        document.querySelector("#password_registro").value = "";
        document.querySelector("#password_registro_r").value = "";
        document.querySelector("#nif_registro").value = "";
        document.querySelector("#telefono_registro").value = "";
        document.querySelector("#fnac_registro").value = "";

      })
}


// Comprueba que el usuario esta registrado y guardara su ID en una variable global

function fLogin(){

    let alias = document.querySelector("#alias_login").value;
    let password = document.querySelector("#password_login").value;

    let sql = `SELECT * FROM usuarios WHERE usu_alias = '${alias}' AND usu_pass = md5('${password}')`;
    const URL = "assets/php/servidor.php?peticion=EjecutarSelect&sql=" + sql;


    // Se lo pedimos a servidor

            fetch(URL)
            .then((response) => response.json())
            .then((data) => {

            //Para comprobar que funciona
            console.log(data);
              
          })
          
          .finally(()=>{
            document.querySelector('#alias_login').value = "";
            document.querySelector('#password_login').value = "";  
          })

    // En el caso de que este logueado

    if(data.datos.length > 0) {

        // Ocultamos el login 
        document.querySelector("#modal_login").style.display = 'none';
        
        // Mostramos el login de cuando ya esta logueado (el que hace David) o la home


        // Guardamos la variable del ID del usuario
        id_usuario_logueado = data.datos[0].usu_id;


    } else {

        // En el caso de que no este logueado
        document.querySelector("#div_error_login").style.display = 'flex';
        document.querySelector("#div_error_login").innerHTML = "Username o contraseña incorrecta. Acceso denegado."
    }
        
}

function fMostrarHotelesCiudad(id_ciudad){

    let sql = `SELECT * FROM hoteles where hot_ciu_id = ${id_ciudad}`;
    const URL = "assets/php/servidor.php?peticion=EjecutarSelect&sql=" + sql;

    fetch(URL)
            .then((response) => response.json())
            .then((data) => {

            //Para comprobar que funciona
            console.log(data);

            let html = "";
            for (let i = 0; i < data.datos.length; i++) {
               
                html += `<div class="sh_hotel" onclick="imprimir(${data.datos[i].hot_id})">`;
                html +=     `<div class="sh_datos_hotel">`
                html +=         `<div class="sh_nombre_hotel">${data.datos[i].hot_nombre}</div>`;
                html +=         `<div class="sh_precio_noche">${data.datos[i].hot_precio_noche} €</div>`;
                html +=     `</div>`;
                html +=     `<div class="sh_imagen_logo">`;
                html +=     `<img src="assets/imagenes/${data.datos[i].hot_logo}">`;
                html +=     `</div>`;
                html += `</div>`;
            }

            console.log(html);

            document.querySelector("#modal_seleccionar_hotel").innerHTML = html;

          })

          .finally(()=>{
            
            fMostrarModal("#modal_seleccionar_hotel");
            
          })

}

function imprimir(x){
    console.log(x)
}

