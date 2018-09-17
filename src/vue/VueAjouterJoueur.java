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
import modele.Joueur;

public class VueAjouterJoueur extends Application {

	protected TextField valeurNom;
	protected TextField valeurNaissance;
	protected TextField valeurNationalite;
	protected Button actionEnregistrerJoueur = null;

	@Override
	public void start(Stage stade) throws Exception {
		VBox panneau = new VBox();
 		GridPane grilleJoueur = new GridPane();
		
		this.actionEnregistrerJoueur = new Button("Enregistrer");
		
		this.actionEnregistrerJoueur.setOnAction(new EventHandler<ActionEvent>() {
 			@Override
			public void handle(ActionEvent arg0) {
 				System.out.println("VueAjouterJoueur.actionEnregistrerJoueur()");
			}});
		
		valeurNom = new TextField();
		grilleJoueur.add(new Label("Nom : "), 0, 0);
		grilleJoueur.add(valeurNom, 1, 0);
		
		valeurNaissance = new TextField();
		grilleJoueur.add(new Label("Naissance : "), 0, 1);
		grilleJoueur.add(valeurNaissance, 1, 1);
		
		valeurNationalite = new TextField();
		grilleJoueur.add(new Label("Région : "), 0, 2);
		grilleJoueur.add(valeurNationalite, 1, 2);
		
		panneau.getChildren().add(new Label("Ajouter un joueur"));
		panneau.getChildren().add(grilleJoueur);
		panneau.getChildren().add(this.actionEnregistrerJoueur);
		
		stade.setScene(new Scene(panneau, 400, 400));
		stade.show();
	}
}