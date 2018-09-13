package vue;



import action.ControleurEquipe;
import action.ControleurJoueur;
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
	private ControleurJoueur controleurJoueur = null;
	protected Button actionEnregistrerJoueur = null;

	@Override
	public void start(Stage stade) throws Exception {
		VBox panneau = new VBox();

		GridPane grilleJoueur = new GridPane();
		
		this.actionEnregistrerJoueur = new Button("Enregistrer");
		
		this.actionEnregistrerJoueur.setOnAction(new EventHandler<ActionEvent>() {
 			@Override
			public void handle(ActionEvent arg0) {
				
				//controleurJoueur.notifierEnregistrerNouvelleEquipe();
				
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
	
	public void setControleurEquipe(ControleurJoueur controleurJoueur) {
		this.controleurJoueur = controleurJoueur;
	}
	
	public Joueur demanderJoueur()
	{
		Joueur joueur = new Joueur(this.valeurNom.getText(), this.valeurNationalite.getText(), this.valeurNaissance.getText());
		return joueur;
	}
}