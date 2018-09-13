package vue;

import action.ControleurEquipe;
import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;
import modele.Equipe;

public class VueAjouterEquipe extends Scene {

	protected TextField valeurNom;
	protected TextField valeurAnneeDeCreation;
	protected TextField valeurRegion;
	private ControleurEquipe controleurEquipe = null;
	protected Button actionEnregistrerEquipe = null;

	public VueAjouterEquipe() {
		super(new VBox(), 400, 400);
		VBox panneau = (VBox) this.getRoot();

		GridPane grilleEquipe = new GridPane();
		
		this.actionEnregistrerEquipe = new Button("Enregistrer");
		
		this.actionEnregistrerEquipe.setOnAction(new EventHandler<ActionEvent>() {
 			@Override
			public void handle(ActionEvent arg0) {
				
				controleurEquipe.notifierEnregistrerNouvelleEquipe();
				
			}});
		
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
		panneau.getChildren().add(this.actionEnregistrerEquipe);
	}
	
	public void setControleurEquipe(ControleurEquipe controleurEquipe) {
		this.controleurEquipe = controleurEquipe;
	}
	
	public Equipe demanderEquipe()
	{
		Equipe equipe = new Equipe(this.valeurNom.getText(), this.valeurAnneeDeCreation.getText(), this.valeurRegion.getText());
		return equipe;
	}
}