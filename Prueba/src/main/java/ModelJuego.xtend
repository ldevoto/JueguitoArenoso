import java.util.List
import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.annotations.Dependencies

@Accessors
@Observable
class ModelJuego extends Juego{
	List<Boolean> triedPassword
	
	new (){
		super()
	}
	
	def initializeTriedPassword(){
		triedPassword = new ArrayList()
		newIntArrayOfSize(6).forEach[triedPassword.add(false)]
	}
	
	override restart(){
		initializeTriedPassword()
		super.restart()
	}
	
	def void probar(){
		probar(triedPassword)
	}
	
	@Dependencies("intentos")
	def Boolean getValor0(){
		return triedPassword.get(0)
	}
	
	def void setValor0(Boolean valor){
		triedPassword.set(0, valor)
	}
	
	@Dependencies("intentos")
	def Boolean getValor1(){
		return triedPassword.get(1)
	}
	
	def void setValor1(Boolean valor){
		triedPassword.set(1, valor)
	}
	
	@Dependencies("intentos")
	def Boolean getValor2(){
		return triedPassword.get(2)
	}
	
	def void setValor2(Boolean valor){
		triedPassword.set(2, valor)
	}
	
	@Dependencies("intentos")
	def Boolean getValor3(){
		return triedPassword.get(3)
	}
	
	def void setValor3(Boolean valor){
		triedPassword.set(3, valor)
	}
	
	@Dependencies("intentos")
	def Boolean getValor4(){
		return triedPassword.get(4)
	}
	
	def void setValor4(Boolean valor){
		triedPassword.set(4, valor)
	}
	
	@Dependencies("intentos")
	def Boolean getValor5(){
		return triedPassword.get(5)
	}
	
	def void setValor5(Boolean valor){
		triedPassword.set(5, valor)
	}

	@Dependencies("estado")
	def boolean getSigueJugando(){
		return ! finDelJuego
	}
	
	@Dependencies("intentos", "estado")
	def String getLeyendaErrores(){
		return getLeyendaErrores(triedPassword)
	}
}