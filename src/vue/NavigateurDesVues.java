package vue;

import java.util.ArrayList;
import java.util.List;

import controleur.ControleurEquipe;
import javafx.application.Application;
import javafx.stage.Stage;
import modele.Equipe;
 public class NavigateurDesVues extends Application{
	
	private Stage stade;
	private VueAjouterEquipe vueAjouterEquipe = null;
	private VueListeEquipe vueListeEquipe = null;
	private VueEquipe vueEquipe = null;
	private ControleurEquipe controleurEquipe = null;
	
	public NavigateurDesVues() 
	{
		
		this.vueAjouterEquipe = new VueAjouterEquipe();
		this.vueListeEquipe = new VueListeEquipe();
		this.vueEquipe = new VueEquipe();

	}
	
	@Override
	public void start(Stage stade) throws Exception {
		this.stade = stade;
		this.stade.setScene(this.vueListeEquipe);
		this.stade.show();
		this.controleurEquipe = ControleurEquipe.getInstance();
		this.controleurEquipe.activerVues(this);
	}

	public VueAjouterEquipe getVueAjouterEquipe() {
		return vueAjouterEquipe;
	}

	public VueListeEquipe getVueListeEquipe() {
		return vueListeEquipe;
	}

	public VueEquipe getVueEquipe() {
		return vueEquipe;
	}	
	
	public void naviguerVersVueEquipe() {
		stade.setScene(this.vueEquipe);
		stade.show();
	}
	
	public void naviguerVersVueListeEquipe() {
		stade.setScene(this.vueListeEquipe);
		stade.show();
	}
	
	public void naviguerVersVueAjouterEquipe() {
		stade.setScene(this.vueAjouterEquipe);
		stade.show();
	}
}