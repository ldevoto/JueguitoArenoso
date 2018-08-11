import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.CheckBox
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class Check {
	new(Panel panel, String bind){
		new CheckBox(panel) => [
			value <=> bind
			width = 40
		]		
	}
}