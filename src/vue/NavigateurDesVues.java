package vue;

import javafx.application.Application;
import javafx.stage.Stage;
 public class NavigateurDesVues extends Application{
	
	private VueAjouterEquipe vueAjouterEquipe;
	private VueListeEquipe vueListeEquipe;
	private VueEquipe vueEquipe;
	
	public NavigateurDesVues() 
	{
		this.vueAjouterEquipe = new VueAjouterEquipe();
		this.vueListeEquipe = new VueListeEquipe();
		this.vueEquipe = new VueEquipe();
	}
	
	@Override
	public void start(Stage stade) throws Exception {
		stade.setScene(this.vueEquipe);
		stade.show();
	}
	
}