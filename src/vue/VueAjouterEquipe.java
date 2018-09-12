package vue;

import javafx.application.Application;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

public class VueAjouterEquipe extends Scene {

	protected TextField valeurNom;
	protected TextField valeurAnneeDeCreation;
	protected TextField valeurRegion;
	
	public VueAjouterEquipe() {
		super(new VBox(), 400, 400);
		VBox panneau = (VBox) this.getRoot();

		GridPane grilleEquipe = new GridPane();
		
		valeurNom = new TextField();
		grilleEquipe.add(new Label("Nom : "), 0, 0);
		grilleEquipe.add(valeurNom, 1, 0);
		
		valeurAnneeDeCreation = new TextField();
		grilleEquipe.add(new Label("Création : "), 0, 1);
		grilleEquipe.add(valeurAnneeDeCreation, 1, 1);
		
		valeurRegion = new TextField();
		grilleEquipe.add(new Label("Région : "), 0, 2);
		grilleEquipe.add(valeurRegion, 1, 2);
		
		panneau.getChildren().add(new Label("Ajouter une équipe"));
		panneau.getChildren().add(grilleEquipe);
		panneau.getChildren().add(new Button("Enregistrer"));
	}
}