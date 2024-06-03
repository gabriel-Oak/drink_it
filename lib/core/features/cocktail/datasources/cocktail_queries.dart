const getCocktailsQuery = """
  query GetCocktails(\$query: CocktailQuery!) {
    getCocktails(query: \$query) {
      id
      name
      thumb
      category
      measures {
        measure
        ingredient {
          name
        }
      }
    }
  }
""";

const lookupRandomQuery = """
  query GetRandomCocktail {
      getRandomCocktail {
      id
      name
      thumb
      category
      measures {
        measure
        ingredient {
          name
        }
      }
    }
  }
""";

const getCocktailDetailsQuery = """
  query GetCocktailDetail(\$cocktailId: String!) {
    getCocktailDetail(cocktailId: \$cocktailId) {
      id
      name
      thumb
      alcoholic
      glass
      category
      instructions
      instructionsES
      instructionsDE
      instructionsFR
      instructionsIT
      measures {
        measure
        ingredient {
          id
          name
        }
      }
    }
  }
""";
