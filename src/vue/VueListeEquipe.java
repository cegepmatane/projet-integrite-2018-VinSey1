package vue;

import java.util.ArrayList;
import java.util.List;

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

	public VueListeEquipe() {
		super(new Pane(), 400,400);
		Pane panneau = (Pane) this.getRoot();
		
		grilleEquipes = new GridPane();
		
		panneau.getChildren().add(grilleEquipes);	
		
		List listeEquipesTest = new ArrayList<Equipe>();
		listeEquipesTest.add(new Equipe("Fnatic", "2011", "Europe"));
		listeEquipesTest.add(new Equipe("Gambit", "2011", "Europe"));
		listeEquipesTest.add(new Equipe("SKT", "2013", "Corée"));
		this.afficherListeEquipe(listeEquipesTest);
	}
	
	public void afficherListeEquipe(List<Equipe> listeEquipes)
	{
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

}
