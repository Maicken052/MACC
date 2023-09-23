<?php
	//Función para cifrar 
	function encrypt($method, $plain, $vector) {
		$output = "";
		$key = 'This is my secret';
		$output = openssl_encrypt($plain, $method, $key, 0, $vector);
		return $output;
	}

	//Recibir los datos del formulario
	$fecha = $_POST['fecha'];
	$bancoO = $_POST['bancoOrigen'];
	$bancoD = $_POST['bancoDestino'];
	$tipoC = $_POST['tipodeCuenta'];
	$cuentaD = $_POST['cuenta'];
	$persona = $_POST['persona'];
	$valorT = $_POST['valor'];
	$id = $_POST['identificacion'];
	$CUS = $_POST['CUS'];
	$desc = $_POST['descripcion'];
	
	//Mostrar los datos recibidos
	echo "<b>INFORMACIÓN FORMULARIO: </b><br>";
	echo "<b>Fecha:</b> $fecha</br>";
	echo "<b>Banco Origen:</b> $bancoO</br>";
	echo "<b>Banco Destino:</b> $bancoD</br>";
	echo "<b>Tipo de Cuenta:</b> $tipoC</br>";
	echo "<b>Cuenta:</b> $cuentaD</br>";
	echo "<b>Persona:</b> $persona</br>";
	echo "<b>Valor:</b> $valorT</br>";
	echo "<b>Identificación:</b> $id</br>";
	echo "<b>CUS:</b> $CUS</br>";
	echo "<b>Descripción:</b> $desc</br></br>";

	$plain_text = $fecha.$bancoO.$bancoD.$tipoC.$cuentaD.$persona.$valorT.$id.$CUS.$desc;
	echo "<b>Mensaje en claro:</b> $plain_text <br><br>";

	//Cifrar el mensaje con DES
	echo "<b>CIFRADO CON DES: </b><br>";

	//CON ECB
	// Registrar el tiempo de inicio
	$inicio = microtime(true);
	//Cifrar el mensaje
	$encrypted_text = encrypt('DES-EDE', $plain_text, "");
	// Registrar el tiempo de finalización
	$fin = microtime(true);
	// Calcular el tiempo transcurrido en segundos
	$tiempo_transcurrido = $fin - $inicio;
	echo "<b>Mensaje cifrado con ECB:</b> $encrypted_text <br>";
	echo "La función tardó aproximadamente " .number_format($tiempo_transcurrido, 8). " segundos en ejecutarse <br><br>";

	//CON CBC
	// Registrar el tiempo de inicio
	$inicio = microtime(true);
	//Cifrar el mensaje
	$iv_size = openssl_cipher_iv_length('DES-EDE-CBC');
	$iv = random_bytes($iv_size);
	$encrypted_text = encrypt('DES-EDE-CBC', $plain_text, $iv);
	// Registrar el tiempo de finalización
	$fin = microtime(true);
	// Calcular el tiempo transcurrido en segundos
	$tiempo_transcurrido = $fin - $inicio;
	echo "<b>Mensaje cifrado con CBC:</b> $encrypted_text <br>";
	echo "La función tardó aproximadamente " .number_format($tiempo_transcurrido, 8). " segundos en ejecutarse <br><br>";

	//CON CFB
	// Registrar el tiempo de inicio
	$inicio = microtime(true);
	//Cifrar el mensaje
	$iv_size = openssl_cipher_iv_length('DES-EDE-CFB');
	$iv = random_bytes($iv_size);
	$encrypted_text = encrypt('DES-EDE-CFB', $plain_text, $iv);
	// Registrar el tiempo de finalización
	$fin = microtime(true);
	// Calcular el tiempo transcurrido en segundos
	$tiempo_transcurrido = $fin - $inicio;
	echo "<b>Mensaje cifrado con CFB:</b> $encrypted_text <br>";
	echo "La función tardó aproximadamente " .number_format($tiempo_transcurrido, 8). " segundos en ejecutarse <br><br>";

	//CON OFB
	// Registrar el tiempo de inicio
	$inicio = microtime(true);
	//Cifrar el mensaje
	$iv_size = openssl_cipher_iv_length('DES-EDE-OFB');
	$iv = random_bytes($iv_size);
	$encrypted_text = encrypt('DES-EDE-OFB', $plain_text, $iv);
	// Registrar el tiempo de finalización
	$fin = microtime(true);
	// Calcular el tiempo transcurrido en segundos
	$tiempo_transcurrido = $fin - $inicio;
	echo "<b>Mensaje cifrado con OFB:</b> $encrypted_text <br>";
	echo "La función tardó aproximadamente " .number_format($tiempo_transcurrido, 8). " segundos en ejecutarse <br><br>";

	//Cifrar el mensaje con TRIPLE DES
	echo "<b>CIFRADO CON 3DES: </b><br>";

	//CON EBC
	// Registrar el tiempo de inicio
	$inicio = microtime(true);
	//Cifrar el mensaje
	$encrypted_text = encrypt('DES-EDE3', $plain_text, "");
	// Registrar el tiempo de finalización
	$fin = microtime(true);
	// Calcular el tiempo transcurrido en segundos
	$tiempo_transcurrido = $fin - $inicio;
	echo "<b>Mensaje cifrado con CBC:</b> $encrypted_text <br>";
	echo "La función tardó aproximadamente " .number_format($tiempo_transcurrido, 8). " segundos en ejecutarse <br><br>";

	//CON CBC
	// Registrar el tiempo de inicio
	$inicio = microtime(true);
	//Cifrar el mensaje
	$iv_size = openssl_cipher_iv_length('DES-EDE3-CBC');
	$iv = random_bytes($iv_size);
	$encrypted_text = encrypt('DES-EDE3-CBC', $plain_text, $iv);
	// Registrar el tiempo de finalización
	$fin = microtime(true);
	// Calcular el tiempo transcurrido en segundos
	$tiempo_transcurrido = $fin - $inicio;
	echo "<b>Mensaje cifrado con CBC:</b> $encrypted_text <br>";
	echo "La función tardó aproximadamente " .number_format($tiempo_transcurrido, 8). " segundos en ejecutarse <br><br>";

	//CON CFB
	// Registrar el tiempo de inicio
	$inicio = microtime(true);
	//Cifrar el mensaje
	$iv_size = openssl_cipher_iv_length('DES-EDE3-CFB');
	$iv = random_bytes($iv_size);
	$encrypted_text = encrypt('DES-EDE3-CFB', $plain_text, $iv);
	// Registrar el tiempo de finalización
	$fin = microtime(true);
	// Calcular el tiempo transcurrido en segundos
	$tiempo_transcurrido = $fin - $inicio;
	echo "<b>Mensaje cifrado con CFB:</b> $encrypted_text <br>";
	echo "La función tardó aproximadamente " .number_format($tiempo_transcurrido, 8). " segundos en ejecutarse <br><br>";

	//CON OFB
	// Registrar el tiempo de inicio
	$inicio = microtime(true);
	//Cifrar el mensaje
	$iv_size = openssl_cipher_iv_length('DES-EDE3-OFB');
	$iv = random_bytes($iv_size);
	$encrypted_text = encrypt('DES-EDE3-OFB', $plain_text, $iv);
	// Registrar el tiempo de finalización
	$fin = microtime(true);
	// Calcular el tiempo transcurrido en segundos
	$tiempo_transcurrido = $fin - $inicio;
	echo "<b>Mensaje cifrado con OFB:</b> $encrypted_text <br>";
	echo "La función tardó aproximadamente " .number_format($tiempo_transcurrido, 8). " segundos en ejecutarse <br><br>";

	//Cifrar el mensaje con AES
	echo "<b>CIFRADO CON AES: </b><br>";

	//CON ECB
	// Registrar el tiempo de inicio
	$inicio = microtime(true);
	//Cifrar el mensaje 
	$encrypted_text = encrypt('AES-192-ECB', $plain_text, "");
	// Registrar el tiempo de finalización
	$fin = microtime(true);
	// Calcular el tiempo transcurrido en segundos
	$tiempo_transcurrido = $fin - $inicio;
	echo "<b>Mensaje cifrado con ECB:</b> $encrypted_text <br>";
	echo "La función tardó aproximadamente " .number_format($tiempo_transcurrido, 8). " segundos en ejecutarse <br><br>";

	//CON CBC
	// Registrar el tiempo de inicio
	$inicio = microtime(true);
	//Cifrar el mensaje 
	$iv_size = openssl_cipher_iv_length('AES-192-CBC');
	$iv = random_bytes($iv_size);
	$encrypted_text = encrypt('AES-192-CBC', $plain_text, $iv);
	// Registrar el tiempo de finalización
	$fin = microtime(true);
	// Calcular el tiempo transcurrido en segundos
	$tiempo_transcurrido = $fin - $inicio;
	echo "<b>Mensaje cifrado con CBC:</b> $encrypted_text <br>";
	echo "La función tardó aproximadamente " .number_format($tiempo_transcurrido, 8). " segundos en ejecutarse <br><br>";

	//CON CFB
	// Registrar el tiempo de inicio
	$inicio = microtime(true);
	//Cifrar el mensaje 
	$iv_size = openssl_cipher_iv_length('AES-192-CFB');
	$iv = random_bytes($iv_size);
	$encrypted_text = encrypt('AES-192-CFB', $plain_text, $iv);
	// Registrar el tiempo de finalización
	$fin = microtime(true);
	// Calcular el tiempo transcurrido en segundos
	$tiempo_transcurrido = $fin - $inicio;
	echo "<b>Mensaje cifrado con CFB:</b> $encrypted_text <br>";
	echo "La función tardó aproximadamente " .number_format($tiempo_transcurrido, 8). " segundos en ejecutarse <br><br>";

	//CON OFB
	// Registrar el tiempo de inicio
	$inicio = microtime(true);
	//Cifrar el mensaje 
	$iv_size = openssl_cipher_iv_length('AES-192-OFB');
	$iv = random_bytes($iv_size);
	$encrypted_text = encrypt('AES-192-OFB', $plain_text, $iv);
	// Registrar el tiempo de finalización
	$fin = microtime(true);
	// Calcular el tiempo transcurrido en segundos
	$tiempo_transcurrido = $fin - $inicio;
	echo "<b>Mensaje cifrado con OFB:</b> $encrypted_text <br>";
	echo "La función tardó aproximadamente " .number_format($tiempo_transcurrido, 8). " segundos en ejecutarse <br><br>";
?>