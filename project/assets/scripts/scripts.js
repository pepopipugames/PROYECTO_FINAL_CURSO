// VARIABLES GLOBALES

let id_usuario_logueado = ""; // ID DEL USUARIO CUANDO SE REGISTRA

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

    console.log("HOLA")

    document.querySelector(nombre_modal_con_almohadilla).style.display = "flex";

    

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

