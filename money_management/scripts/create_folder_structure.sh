cd ..
cd lib

# Constants folder
mkdir "constants"
mkdir -p "constants/resources"

touch "constants/resources/.gitkeep"
touch "constants/constants.dart"

# Utilities folder
mkdir "utilities"
mkdir -p "utilities/extensions"

touch "utilities/extensions/.gitkeep"
touch "utilities/utilities.dart"

# Data folder
mkdir "data"

mkdir -p "data/models"

mkdir -p "data/models/api"
mkdir -p "data/models/api/requests"
touch "data/models/api/requests/.gitkeep"
mkdir -p "data/models/api/responses"
touch "data/models/api/responses/.gitkeep"

mkdir -p "data/models/db"
touch "data/models/db/.gitkeep"

mkdir -p "data/providers"
touch "data/providers/.gitkeep"

mkdir -p "data/repositories"
touch "data/repositories/.gitkeep"

mkdir -p "data/data_sources"
touch "data/data_sources/.gitkeep"

# Presentation folder
mkdir "presentation"
mkdir -p "presentation/common_widgets"
mkdir -p "presentation/common_widgets/base"
touch "presentation/common_widgets/base/.gitkeep"

mkdir -p "presentation/features"
mkdir -p "presentation/features/home"

mkdir -p "presentation/features/home/widgets"
touch "presentation/features/home/widgets/.gitkeep"

mkdir -p "presentation/features/home/models"
touch "presentation/features/home/models/.gitkeep"

touch "presentation/features/home/home_screen.dart"
touch "presentation/features/home/home_view_model.dart"
touch "presentation/features/home/home_state.dart"

touch "presentation/app.dart"
