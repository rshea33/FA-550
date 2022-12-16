import pandas as pd
from sys import argv


def clean_weather(path, df_name):

    df = pd.read_csv(path)

    relevant_columns = [
        'pitches',
        'player_id',
        'api_game_date_month_text',
        'total_pitches',
        'pitch_percent',
        'ba',
        'iso',
        'babip',
        'slg',
        'woba',
        'xba',
        'hits',
        'abs',
        'launch_speed',
        'launch_angle',
        'spin_rate',
        'velocity',
        'effective_speed',
        'whiffs',
        'swings'
    ]
    df = df[relevant_columns]

    city_map = {
        'ATL': 'Atlanta, GA',
        'AZ': 'Phoenix, AZ',
        'BAL': 'Baltimore, MD',
        'BOS': 'Boston, MA',
        'CHC': 'Chicago, IL',
        'CIN': 'Cincinnati, OH',
        'CLE': 'Cleveland, OH',
        'COL': 'Denver, CO',
        'CWS': 'Chicago, IL',
        'DET': 'Detroit, MI',
        'HOU': 'Houston, TX',
        'KC': 'Kansas City, MO',
        'LAA': 'Anaheim, CA',
        'LAD': 'Los Angeles, CA',
        'MIA': 'Miami, FL',
        'MIL': 'Milwaukee, WI',
        'MIN': 'Minneapolis, MN',
        'NYM': 'New York, NY',
        'NYY': 'New York, NY',
        'OAK': 'Oakland, CA',
        'PHI': 'Philadelphia, PA',
        'PIT': 'Pittsburgh, PA',
        'SD': 'San Diego, CA',
        'SEA': 'Seattle, WA',
        'SF': 'San Francisco, CA',
        'STL': 'St. Louis, MO',
        'TB': 'Tampa, FL',
        'TEX': 'Arlington, TX',
        'TOR': 'Toronto, ON',
        'WSH': 'Washington, DC'
    }

    df['city'] = df['player_id'].map(city_map)
    df.to_csv(f'Data/{df_name}', index=False)




def main():

    if len(argv) != 3:
        print("Usage: python weather_clean.py <path> <df_name>")
        exit(1)

    path = argv[1]
    df_name = argv[2]
    clean_weather(path, df_name)

if __name__ == '__main__':
    main()