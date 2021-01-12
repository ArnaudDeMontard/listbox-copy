//%attributes = {"lang":"en"} comment added and reserved by 4D.
//LBes_copy (listboxNom_t;entitySel_o) -> txt
//$0 : contenu de la listbox entitySelection dans le presse papier
// au format tab tab retour

//© Arnaud * 11/01/2021 
C_TEXT:C284($1;$lb_t)
C_OBJECT:C1216($2;$entitySel_o)

C_LONGINT:C283($prog_l)
C_COLLECTION:C1488($formule_c)
C_TEXT:C284($sepCol_t;$sepLigne_t)

ASSERT:C1129(Count parameters:C259>1;Current method name:C684+" 2 paramètres attendus")
$lb_t:=$1
$entitySel_o:=$2

LISTBOX GET OBJECTS:C1302(*;$lb_t;$objet_at)
$formule_c:=New collection:C1472
For ($i_l;1;Size of array:C274($objet_at);3)
	If (OBJECT Get visible:C1075(*;$objet_at{$i_l}))
		$formule_c.push(Formula from string:C1601(LISTBOX Get column formula:C1202(*;$objet_at{$i_l})))
	End if 
End for 

$sepCol_t:="\t"
$sepLigne_t:="\r"
$dataClassNom_t:=$entitySel_o.getDataClass().getInfo().name
$sortie_c:=New collection:C1472()
For each ($entity_o;$entitySel_o)  //lignes
	For each ($formule_o;$formule_c)  //colonnes
		$sortie_c.push(String:C10($formule_o.call($entity_o))+$sepCol_t)
	End for each 
	$sortie_c.push($sepLigne_t)
End for each 

$0:=$sortie_c.join("")
