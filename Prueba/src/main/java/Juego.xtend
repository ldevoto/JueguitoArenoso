import java.util.List
import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Random
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Dependencies

@Accessors
@Observable
class Juego {
	Estado estado
	Integer intentos
	List<Boolean> password
	Random aleatorio = new Random(System.currentTimeMillis());
	
	new (){
		restart()
	}
	
	def generatePassword() {
		password = new ArrayList()
		newIntArrayOfSize(6).forEach[password.add(this.getRandomValue())]
	}
	
	def boolean getRandomValue(){
		return 1 == aleatorio.nextInt(2)
	}
	
	def restart(){
		estado = new EnJuego(this)
		intentos = 5
		generatePassword()
	}
	
	def void probar(List<Boolean> triedPassword){
		estado.probar(triedPassword)
	}
	
	@Dependencies("estado")
	def boolean getFinDelJuego(){
		return estado.esFinDelJuego()
	}
	
	@Dependencies("intentos", "estado")
	def String getEstadoJuego(){
		return estado.getEstadoJuego()
	}
	
	def esPassword(List<Boolean> triedPassword){
		return getCantidadErrores(triedPassword) == 0
	}
	
	def String getLeyendaErrores(List<Boolean> triedPassword){
		return estado.getLeyendaErrores(triedPassword)
	}
	
	def int getCantidadErrores(List<Boolean> triedPassword){
		var cantidad = 0
		for (var i = 0 ; i < 6 ; i++) {
		  if (! password.get(i).equals(triedPassword.get(i))){
		  	cantidad++
		  }
		}
		return cantidad
	}
	
	def reducirIntentos() {
		intentos--
	}
	
	def boolean quedanIntentos() {
		return intentos > 0
	}
	
	def esElInicio() {
		return intentos == 5
	}
	
}

abstract class Estado {
	protected Juego juego
	new (Juego juego){
		this.juego = juego
	}
	def esFinDelJuego() {
		return true
	}
	
	def String getEstadoJuego()
	
	def probar(List<Boolean> triedPassword){
	}
	
	def String getLeyendaErrores(List<Boolean> triedPassword)
}

class EnJuego extends Estado{
	
	new(Juego juego) {
		super(juego)
	}
	
	override esFinDelJuego() {
		return false
	}
	
	override getEstadoJuego() {
		if (juego.esElInicio()){
			return "Hasta que no pruebes.. nada cambia"
		}
		return "Vamos que te quedan " + juego.intentos + " intentos"
	}
	
	override probar(List<Boolean> triedPassword){
		if (juego.esPassword(triedPassword)){
			juego.estado = new Ganado(juego)
		} else {
			juego.reducirIntentos()
			if (!juego.quedanIntentos()){
				juego.estado = new Perdido(juego)
			}
		}
		return void
	}
	
	override getLeyendaErrores(List<Boolean> triedPassword) {
		var cantidad = juego.getCantidadErrores(triedPassword)
		if (juego.esElInicio()){
			return "Tilda y proba"
		}
		if (cantidad == 1){
			return "Nop, queda solo 1 error"
		}
		return "Nop, hay " + cantidad + " errores"
	}
	
}

class Ganado extends Estado{
	
	new(Juego juego) {
		super(juego)
	}
	
	override getEstadoJuego() {
		return "Ganaste papa!"
	}
	
	override getLeyendaErrores(List<Boolean> triedPassword) {
		return "Muy bien y lo hiciste tu solito"
	}
	
}

class Perdido extends Estado{
	
	new(Juego juego) {
		super(juego)
	}
	
	override getEstadoJuego() {
		return "Perdistess"
	}
	
	override getLeyendaErrores(List<Boolean> triedPassword) {
		return "Casi casi. Falto nivel"
	}
	
}