<?php
	echo "<form action='transaction.php' method='post'>";
	echo "<table align='center' border='1'>";
	
	//Casilla Fecha
	echo "<tr><td>Fecha</td><td><input type = 'datetime-local' name = 'fecha'></td></tr>";
	
	//Casilla Banco Origen
	echo "<tr><td>Banco Origen</td>";
	echo "<td><select name = 'bancoOrigen'>";
	echo "<option value = 'Bancolombia' > Bancolombia</option>";
	echo "<option value = 'Davivienda' > Davivienda</option>";
	echo "<option value = 'BBVA' > BBVA</option>";
	echo "</select>";
	echo "</td></tr>";
	
	//Casilla Banco Destino
	echo "<tr><td>Banco Destino</td>";
	echo "<td><select name = 'bancoDestino'>";
	echo "<option value = 'Bancolombia' > Bancolombia</option>";
	echo "<option value = 'Davivienda' > Davivienda</option>";
	echo "<option value = 'BBVA' > BBVA</option>";
	echo "</select>";
	echo "</td></tr>";
	
	//Casilla Tipo de Cuenta 
	echo "<tr><td>Tipo de Cuenta Destino</td>";
	echo "<td><select name = 'tipodeCuenta'>";
	echo "<option value = 'Ahorros' > Ahorros</option>";
	echo "<option value = 'Corriente' > Corriente</option>";
	echo "</select>";
	echo "</td></tr>";
	
	//Casilla Nùm de cuenta de destino
	echo "<tr><td>Número de Cuenta</td><td><input type = 'text' name = 'cuenta'></td></tr>";
	
	//Casilla Tipo de Persona 
	echo "<tr><td>Persona</td>";
	echo "<td><select name = 'persona'>";
	echo "<option value = 'Natural' > Natural</option>";
	echo "<option value = 'Jurídica' > Jurídica</option>";
	echo "</select>";
	echo "</td></tr>";
	
	//Casilla valor transacción
	echo "<tr><td>Valor Transacción</td><td><input type = 'number' name = 'valor'></td></tr>";
	
	//Casilla Identificación
	echo "<tr><td>Identificación</td><td><input type  = 'number' name = 'identificacion'></td></tr>";
	
	//Casilla CUS
	echo "<tr><td>CUS</td><td><input type  = 'number' name = 'CUS'></td></tr>";
	
	//Casilla Descripción
	echo "<tr><td>Descripción</td><td><input type = 'text' name = 'descripcion'></td></tr>";
	
	echo "<tr><th colspan = '2'><input type = 'submit' values = 'Aceptar'></th></tr>";

	echo "</table>";
	echo "</form>";
?>