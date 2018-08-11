import org.uqbar.arena.windows.MainWindow
import org.uqbar.arena.widgets.Panel
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button

/**
 * Jueguito basico
 */
class JuegoVisual extends MainWindow<ModelJuego> {
	
	new() {
		super(new ModelJuego())
	}

	override createContents(Panel mainPanel) {
//		this.minHeight = 200
//		this.minWidth = 200
		this.title = "Jueguito Loco"
					
		new Label(mainPanel).text = "Adivina el codigo..."
		
		val pane = new Panel(mainPanel) => [
			it.layout = new ColumnLayout(6)
		]
		
		{1..6}.forEach[valor | new Check(pane, "valor" + (valor - 1))]
		
		new Label(mainPanel) => [
			value <=> "leyendaErrores"
		]
		
		new Button(mainPanel) => [
			it.caption = "Probar.."
			it.setAsDefault()
			it.onClick [| modelObject.probar]
			it.enabled <=> "sigueJugando"
		]
		
		new Label(mainPanel) => [
			value <=> "estadoJuego"
		]
		
		new Button(mainPanel) => [
			it.caption = "Reiniciar"
			it.onClick[modelObject.restart]
			it.visible <=> "finDelJuego"
		]
	}

	def static main(String[] args) {
		new JuegoVisual().startApplication
	}
}