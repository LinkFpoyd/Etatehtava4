<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Asiakaslista</title>

</head>
<body onkeydown="tutkiKey(event)">
<table id="listaus">
	<thead>
		<tr>
			<th colspan="5" class="oikea"></th>
			<th><a id="uusiAsiakas" href="lisaaasiakas.jsp">Lisää uusi asiakas</a></th>
		</tr>
		
		<tr>
		<th class="oikea">Hakusana:</th>
		<th colspan="4"><input type="text" id="hakusana"></th>
		
		<th style= "text-align: left;">
		<input type="button" value="hae" id="hakunappi">
		</th>
		
		</tr>
		
		<tr class="taulu">
			<th>Asiakasid</th>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sposti</th>
			<th></th>
		</tr>
		</thead>
		<tbody id="tbody">
		</tbody>
</table>
<script>
haeAsiakkaat();	
document.getElementById("hakusana").focus(); //viedään kursori hakusana-kenttään sivun latauksen yhteydessä

function tutkiKey(event){
	if(event.keyCode==13){//Enter
		haeAsiakkaat();
	}		
}

function haeAsiakkaat(){
	document.getElementById("tbody").innerHTML = "";
	fetch("asiakkaat/" + document.getElementById("hakusana").value,{//Lähetetään kutsu backendiin
	      method: 'GET'
	    })
	.then(function (response) {//Odotetaan vastausta ja muutetaan JSON-vastaus objektiksi
		return response.json()	
	})
	.then(function (responseJson) {//Otetaan vastaan objekti responseJson-parametrissä		
		var asiakkaat = responseJson.asiakkaat;	
		var htmlStr="";
		for(var i=0;i<asiakkaat.length;i++){			
        	htmlStr+="<tr>";
        	htmlStr+="<td>"+asiakkaat[i].asiakasid+"</td>";
        	htmlStr+="<td>"+asiakkaat[i].etunimi+"</td>";
        	htmlStr+="<td>"+asiakkaat[i].sukunimi+"</td>";
        	htmlStr+="<td>"+asiakkaat[i].puhelin+"</td>";
        	htmlStr+="<td>"+asiakkaat[i].sposti+"</td>";  
        	htmlStr+="<td><a href='muutaasiakas.jsp?asiakasid="+asiakkaat[i].asiakasid+"'>Muuta</a>&nbsp;";
        	htmlStr+="<span class='poista' onclick=poista('"+asiakkaat[i].asiakasid+"')>Poista</span></td>";
        	htmlStr+="</tr>";        	
		}
		document.getElementById("tbody").innerHTML = htmlStr;		
	})
}

function poista(asiakasid) {
	if(confirm("Poista asiakas " + asiakasid +"?")){	
		fetch("asiakkaat/"+ asiakasid,{//Lähetetään kutsu backendiin
		      method: 'DELETE'		      	      
		    })
		.then(function (response) {//Odotetaan vastausta ja muutetaan JSON-vastaus objektiksi
			return response.json()
		})
		.then(function (responseJson) {//Otetaan vastaan objekti responseJson-parametrissä		
			var vastaus = responseJson.response;		
			if(vastaus==0){
				document.getElementById("ilmo").innerHTML= "Asiakkaan poisto epäonnistui.";
	        }else if(vastaus==1){	        	
	        	document.getElementById("ilmo").innerHTML="Asiakkaan " + asiakasid +" poisto onnistui.";
				haeTiedot();        	
			}	
			setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
		})		
	}
}


</script>

</body>
</html>