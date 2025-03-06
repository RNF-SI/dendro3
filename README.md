# Dendro3

Une application mobile pour la saisie de protocole PSDRF. Elle permet aux professionnels forestiers de collecter, gérer et synchroniser des données forestières, en particulier les mesures dendrométriques.

## Fonctionnalités

- **Système d'authentification**: Connexion sécurisée pour les utilisateurs sur le terrain
- **Gestion des données hors ligne**: Travaillez sans connexion internet sur le terrain
- **Inventaire**: Saississez et gérez les données PSDRF
- **Synchronisation des données**: Synchronisation unidirectionnelle du mobile vers le serveur de staging
- **Export de base de données**: Exportation des données collectées pour sauvegarde ou analyse

## Détails techniques

Dendro3 est construit avec:

- **Flutter**: Framework UI multiplateforme
- **Riverpod**: Solution de gestion d'état
- **SQLite**: Base de données locale pour le stockage hors ligne
- **GoRouter**: Navigation et routage
- **Freezed**: Modèles de données immuables
- **Dio**: Client HTTP pour la communication API
- **Clean Architecture**: Séparation des couches domaine, données et présentation

## Démarrage rapide

### Prérequis

- Flutter SDK 2.18.4 ou supérieur
- Dart SDK
- Android Studio / VS Code avec extensions Flutter

### Installation

1. Clonez le dépôt

```bash
git clone https://github.com/RNF-SI/dendro3
cd dendro3
```

2. Installez les dépendances

```bash
flutter pub get
```

3. Lancez l'application

```bash
flutter run
```

## Structure du projet

- `lib/domain/`: Logique métier et entités
- `lib/data/`: Sources de données et dépôts
- `lib/presentation/`: Composants UI et modèles de vue
- `assets/`: Ressources statiques et scripts d'initialisation de base de données

## Note importante

Cette version de l'application est conçue pour un seul appareil mobile par dispositif forestier. La synchronisation fonctionne uniquement dans un sens - les données sont prises du serveur de production vers le mobile, puis elles sont envoyés, après saisie, vers un serveur de staging. Toute modification effectuée avec un autre appareil mobile sur une placette différente au sein de votre dispositif ne sera pas visible sur votre téléphone même après synchronisation.

## Licence

Ce projet est sous licence **GNU Affero General Public License v3 (AGPL-3.0)**. Cela signifie que :

- Vous pouvez utiliser, modifier et distribuer ce logiciel librement, à condition de respecter les termes de la licence.
- Si vous modifiez et déployez ce logiciel sur un serveur accessible publiquement, vous devez fournir le code source de votre version modifiée.
- Il n'y a aucune garantie, explicite ou implicite, concernant ce logiciel.

Pour plus de détails, consultez le fichier [`LICENSE`](./LICENSE) ou la page officielle de la licence : [GNU AGPL-3.0](https://www.gnu.org/licenses/agpl-3.0.html).

## Contact

antoine.schlegel@rnfrance.org
