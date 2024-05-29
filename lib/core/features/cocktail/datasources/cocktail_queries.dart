const getCocktailsQuery = """
  "query GetCocktails(\$query: CocktailQuery!) {
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
