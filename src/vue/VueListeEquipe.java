package vue;

import java.util.ArrayList;
import java.util.List;

import action.ControleurEquipe;
import javafx.application.Application;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.Pane;
import javafx.stage.Stage;
import modele.Equipe;

public class VueListeEquipe extends Scene {

	protected GridPane grilleEquipes;
	private ControleurEquipe controleurEquipe = null;

	public VueListeEquipe() {
		super(new GridPane(), 400,400);
		grilleEquipes = (GridPane) this.getRoot();
		
	}
	
	public void afficherListeEquipe(List<Equipe> listeEquipes)
	{
		this.grilleEquipes.getChildren().clear();
		int numero = 0;
		this.grilleEquipes.add(new Label("Nom"), 0, numero);
		this.grilleEquipes.add(new Label("Année de création"), 1, numero);
		this.grilleEquipes.add(new Label("Région"), 2, numero);
		for(Equipe equipe : listeEquipes)
		{
			numero++;
			this.grilleEquipes.add(new Label(equipe.getNom()), 0, numero);
			this.grilleEquipes.add(new Label(equipe.getAnneeDeCreation()), 1, numero);			
			this.grilleEquipes.add(new Label(equipe.getRegion()), 2, numero);	
		}
	}

	public void setControleurEquipe(ControleurEquipe controleurEquipe) {
		this.controleurEquipe = controleurEquipe;
	}
}
