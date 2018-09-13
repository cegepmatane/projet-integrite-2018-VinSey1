package vue;

import java.util.ArrayList;
import java.util.List;

import action.ControleurEquipe;
import action.ControleurJoueur;
import javafx.application.Application;
import javafx.stage.Stage;
import modele.Equipe;
 public class NavigateurDesVues extends Application{
	
	private Stage stade;
	private VueAjouterEquipe vueAjouterEquipe = null;
	private VueEditerEquipe vueEditerEquipe = null;
	private VueListeEquipe vueListeEquipe = null;
	private VueEquipe vueEquipe = null;
	private ControleurEquipe controleurEquipe = null;
	private ControleurJoueur controleurJoueur = null;
	private VueAjouterJoueur vueAjouterJoueur = null;
	private VueEditerJoueur vueEditerJoueur = null;
	
	public NavigateurDesVues() 
	{
		
		this.vueAjouterEquipe = new VueAjouterEquipe();
		this.vueListeEquipe = new VueListeEquipe();
		this.vueEquipe = new VueEquipe();
		this.vueEditerEquipe = new VueEditerEquipe();
		this.vueAjouterJoueur = new VueAjouterJoueur();
		this.vueEditerJoueur = new VueEditerJoueur();

	}
	
	@Override
	public void start(Stage stade) throws Exception {
		this.stade = stade;
		this.stade.setScene(null);
		this.stade.show();
		this.controleurEquipe = ControleurEquipe.getInstance();
		this.controleurJoueur = ControleurJoueur.getInstance();
		this.controleurEquipe.activerVues(this);
		this.controleurJoueur.activerVues(this);
		this.vueAjouterJoueur.setControleurJoueur(controleurJoueur);
		this.vueEditerJoueur.setControleurJoueur(controleurJoueur);
		this.vueAjouterEquipe.setControleurEquipe(controleurEquipe);
		this.vueListeEquipe.setControleurEquipe(controleurEquipe);
		this.vueEquipe.setControleurEquipe(controleurEquipe);
		this.vueEditerEquipe.setControleurJoueur(controleurJoueur);
		this.vueEditerEquipe.setControleurEquipe(controleurEquipe);
	}
	
	public VueEditerJoueur getVueEditerJoueur() {
		return vueEditerJoueur;
	}
	
	public VueAjouterJoueur getVueAjouterJoueur() {
		return vueAjouterJoueur;
	}

	public VueEditerEquipe getVueEditerEquipe() {
		return vueEditerEquipe;
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
	
	public void naviguerVersVueAjouterJoueur() {
		stade.setScene(this.vueAjouterJoueur);
		stade.show();
	}
	
	public void naviguerVersVueEditerJoueur() {
		stade.setScene(this.vueEditerJoueur);
		stade.show();
	}
	
	public void naviguerVersVueAjouterEquipe() {
		stade.setScene(this.vueAjouterEquipe);
		stade.show();
	}
	
	public void naviguerVersVueEditerEquipe() {
		stade.setScene(this.vueEditerEquipe);
		stade.show();
	}
}