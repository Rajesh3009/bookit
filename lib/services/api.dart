
class Api {
  Map<String, dynamic> moviesData = {
    "movies": [
      {
        "title": "The Shawshank Redemption",
        "image_url":
            "https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg"
      },
      {
        "title": "The Godfather",
        "image_url":
            "https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg"
      },
      {
        "title": "The Dark Knight",
        "image_url":
            "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg"
      },
      {
        "title": "Pulp Fiction",
        "image_url":
            "https://image.tmdb.org/t/p/w500/dM2w364MScsjFf8pfMbaWUcWrR.jpg"
      },
      {
        "title": "Forrest Gump",
        "image_url":
            "https://image.tmdb.org/t/p/w500/clolk7rB5lAjs41SD0Vt6IXYLMm.jpg"
      },
      {
        "title": "Inception",
        "image_url":
            "https://image.tmdb.org/t/p/w500/qmDpIHrmpJINaRKAfWQfftjCdyi.jpg"
      },
      {
        "title": "Fight Club",
        "image_url":
            "https://image.tmdb.org/t/p/w500/8kNruSfhk5IoE4eZOc4UpvDn6tq.jpg"
      },
      {
        "title": "The Matrix",
        "image_url":
            "https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg"
      },
      {
        "title": "Interstellar",
        "image_url":
            "https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg"
      },
      {
        "title": "The Lord of the Rings: The Return of the King",
        "image_url":
            "https://image.tmdb.org/t/p/w500/9deYkU1mN2rHoI2oE9VQQLHjbY3.jpg"
      }
    ]
  };
Map<String, dynamic> loadData(){
  return moviesData;
}

}