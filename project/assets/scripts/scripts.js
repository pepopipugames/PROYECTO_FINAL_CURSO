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

    let lista_modales = document.querySelectorAll("section > div");


    lista_modales.forEach(item => {
        item.style.display = "none";
        console.log(item)
    });

    document.querySelector(nombre_modal_con_almohadilla).style.display = "flex";
}

// Boton de registrar, hace un insert a usuarios

function fRegistrar() {

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

        .finally(() => {

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

function fLogin() {

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

        .finally(() => {
            document.querySelector('#alias_login').value = "";
            document.querySelector('#password_login').value = "";
        })

    // En el caso de que este logueado

    if (data.datos.length > 0) {

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

function fMostrarHotelesCiudad(id_ciudad) {

    let sql = `SELECT * FROM hoteles where hot_ciu_id = ${id_ciudad}`;
    const URL = "assets/php/servidor.php?peticion=EjecutarSelect&sql=" + sql;

    fetch(URL)
        .then((response) => response.json())
        .then((data) => {

            //Para comprobar que funciona
            console.log(data);

            let html = "";
            for (let i = 0; i < data.datos.length; i++) {

                html += `<div class="sh_hotel" onclick="fGuardarHotelSeleccionado(${data.datos[i].hot_id})">`;
                html += `<div class="sh_datos_hotel">`
                html += `<div class="sh_nombre_hotel">${data.datos[i].hot_nombre}</div>`;
                html += `<div class="sh_precio_noche">${data.datos[i].hot_precio_noche} €</div>`;
                html += `</div>`;
                html += `<div class="sh_imagen_logo">`;
                html += `<img src="assets/imagenes/${data.datos[i].hot_logo}">`;
                html += `</div>`;
                html += `</div>`;
            }

            console.log(html);

            document.querySelector("#modal_seleccionar_hotel").innerHTML = html;

        })

        .finally(() => {

            fMostrarModal("#modal_seleccionar_hotel");

        })

}

function fGuardarHotelSeleccionado(x) {
    id_hotel_seleccionado = x;
    console.log(id_hotel_seleccionado);
    fMostrarModal("#modal_pregunta_actividades");

}
// Muestra la modal principal de preparar viaje (donde eliges la ciudad primero)

function fMostrarPrepararViaje() {
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
                let ciudad_nombre = item.ciu_nombre.replace(/\s+/g, '_');
                lista_ciudades.push(ciudad_nombre);
                lista_fotos.push(item.ciu_foto);
                html += `<div class='ciudades' onclick='fSeleccionarFecha("${ciudad_nombre}")'>`
                html += `    <div id='${ciudad_nombre}'>`
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

// Hallamos la ubicacion del usuarios

async function encontrarUbicacion() {
    return new Promise((resolve, reject) => {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(mostrarCiudad, handleError);
        } else {
            reject("Geolocation is not supported by this browser.");
        }

        function mostrarCiudad(position) {
            const latitud = position.coords.latitude;
            const longitud = position.coords.longitude;
            const url = `https://geocode.maps.co/reverse?lat=${latitud}&lon=${longitud}&api_key=6633f25401912704812043ibt94da09`;

            fetch(url)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('La respuesta del servidor es not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    const ciudadUsuario = data.address.city;
                    console.log(`Estás en ${ciudadUsuario}.`);
                    resolve(ciudadUsuario);
                })
                .catch(error => reject(error));
        }

        function handleError(error) {
            reject(error.message);
        }
    });
}

// Obtenemos la fecha actual

function obtenerFechaActual() {
    const fecha = new Date();

    let dia = fecha.getDate();
    let mes = fecha.getMonth() + 1;
    let year = fecha.getFullYear();

    let fechaActual = `${year}/${mes}/${dia}`;
    return fechaActual;
}

async function fSeleccionarFecha(ciudadDestino) {
    // Obtenemos la fecha actual y la ubicacion
    let hoy = obtenerFechaActual();
    let ciudad_origen = await encontrarUbicacion();
    let html = "";
    // Rellenamos los combos
    let sql = "SELECT * FROM ciudades;";
    let URL = "assets/php/servidor.php?peticion=EjecutarSelect";
    URL += "&sql=" + sql;
    fetch(URL)
        .then((response) => response.json())
        .then((data) => {
            data.datos.forEach(item => {
                html += `<option value="${item.ciu_nombre}" id="${item.ciu_nombre}og">${item.ciu_nombre}</option>`;
            });
            // Populate the dropdowns with options
            document.querySelector("#select_co").innerHTML = html;
            html = "";
            data.datos.forEach(item => {
                html += `<option value="${item.ciu_nombre}" id="${item.ciu_nombre}de">${item.ciu_nombre}</option>`;
            });
            document.querySelector("#select_cd").innerHTML = html;

            // Select the desired options based on the cities
            try {
                document.querySelector(`#${ciudad_origen}og`).selected = true;
                document.querySelector(`#${ciudadDestino}de`).selected = true;
            } catch (error) {
                console.log(error);
                ciudad_origen = "Selecciona la ciudad de origen";
                // Handle the case when city is not found
            }
            // Convertimos hoy a un objeto Date de JavaScript
            let fechaActual = new Date(hoy);
            // Formateamos la fechaActual a yyyy-MM-dd
            let fechaFormateada = fechaActual.toISOString().split('T')[0];

            // Establecemos el valor y el mínimo del input de la fecha de inicio con el día actual 
            document.querySelector("#fecha_vuelta").value = fechaFormateada;
            document.querySelector("#fecha_vuelta").min = fechaFormateada;
            fMostrarModal("#modal_seleccionar_transporte");
        })
        .catch((error) => {
            console.log(error);
            // Handle fetch error
        });
}

// Realizamos una solicitud de autocompletado para un código IATA
// Devuelve sugerencias de nombres
async function buscarIDCiudad(codigoIATA, fecha) {
    if (fecha != null) {
        const options = {
            method: 'GET',
            url: 'https://sky-scanner3.p.rapidapi.com/flights/auto-complete',
            params: {
                query: codigoIATA,
                outbounddate: fecha
            },
            headers: {
                'X-RapidAPI-Key': '1d4918bd48msh338061def102284p1b582ejsn97259beec7b9',
                'X-RapidAPI-Host': 'sky-scanner3.p.rapidapi.com'
            }
        };

        try {
            const respuesta = await axios.request(options);
            // respuesta.data.data? chequea si respuesta.data.data existe
            // find() busca dentro del array si navigation y entityId existen
            // Lo que hace el metodo find es devolver el primer elemento de un array que cumpla con una funcion de prueba
            // La funcion de prueba es item => item.navigation?.entityId (Si navigation y entityId existen)
            // ?.navigation.entityId; Accede a los datos. La interrogacion hace que devuelve undefined si no ha encontrado nada
            // Usamos find porque siempre vamos a querer devolver el primer resultado de las sugerencias ya que es el correcto.
            // Por ejemplo, el codigo IATA MAD, devuelve Madrid en la primera posicion pero Madeira en la 7. El codigo de IATA de Madeira no es MAD.
            // Son las 5am. Me ha llevado 3 horas la funcion esta :S
            const entityId = respuesta.data.data?.find(item => item.navigation?.entityId)?.navigation.entityId;
            if (entityId) {
                return entityId;
            } else {
                console.error("No entityId found in the response data.");
            }
        } catch (error) {
            console.error("Error fetching data:", error);
        }
    }
}


async function fMostrarTransportes() {
    let ciudad_origen = document.querySelector("#select_co").value;
    let ciudad_destino = document.querySelector("#select_cd").value;

    let ciudad_origen_id;
    let ciudad_origen_codigo;
    let ciudad_destino_id;
    let ciudad_destino_codigo;

    let fecha_ida = document.querySelector("#fecha_ida").value;
    let fecha_vuelta = document.querySelector("#fecha_vuelta").value;

    let c_org_vuelo_entidad_id;
    let c_dest_vuelo_entidad_id;
    let c_org_hotel_entidad_id;
    let c_dest_hotel_entidad_id;

    console.log(fecha_ida, fecha_vuelta);
    // Pedir al servidor que nos devuelva el id de la ciudad y el codigo del aeropuerto de las ciudades
    let sql = `SELECT ciu_id, ciu_codigo FROM ciudades WHERE ciu_nombre = '${ciudad_origen}' OR ciu_nombre = '${ciudad_destino}'`;
    let URL = "assets/php/servidor.php?peticion=EjecutarSelect";
    URL += "&sql=" + sql;
    fetch(URL)
        .then((response) => response.json())
        .then(async (data) => {
            ciudad_origen_id = data.datos[0].ciu_id;
            ciudad_origen_codigo = data.datos[0].ciu_codigo;

            ciudad_destino_id = data.datos[1].ciu_id;
            ciudad_destino_codigo = data.datos[1].ciu_codigo;

            try {
                c_org_vuelo_entidad_id = await buscarIDCiudad(ciudad_origen_codigo, fecha_ida);
                c_dest_vuelo_entidad_id = await buscarIDCiudad(ciudad_destino_codigo, fecha_vuelta);
            } catch (error) {
                console.error("Error al buscar el ID de la ciudad:", error);
            }
        })
};  