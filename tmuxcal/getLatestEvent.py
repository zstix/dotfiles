# TODO: save to a /tmp file
# TODO: display in tmux
# TODO: color based on proximity
# TODO: run pyton on interval (15 min?) with instructions in comments
# TODO: check into dotfiles (except creds file - keybase or something)

from __future__ import print_function
import datetime
import pickle
import os.path
from googleapiclient.discovery import build
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request

SCOPES = ['https://www.googleapis.com/auth/calendar.readonly']
LIST_FILE = '/tmp/tmuxcal/list.txt'
NEXT_FILE = '/tmp/tmuxcal/next.txt'

def get_service():
    creds = None

    if os.path.exists('token.pickle'):
        with open('token.pickle', 'rb') as token:
            creds = pickle.load(token)

    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file('credentials.json', SCOPES)
            creds = flow.run_local_server(port=0)
        with open('token.pickle', 'wb') as token:
            pickle.dump(creds, token)

    return build('calendar', 'v3', credentials=creds)

def get_event_desc(event):
    start = event['start'].get('dateTime', event['start'].get('date'))
    start_time = datetime.datetime.fromisoformat(start).strftime('%H:%M')
    return start_time + ' ' + event['summary'][0:20]

def get_events():
    service = get_service()

    now = datetime.datetime.utcnow().isoformat() + 'Z'
    events_result = service.events().list(calendarId='primary', timeMin=now,
            maxResults=10, singleEvents=True, orderBy='startTime').execute()
    events = events_result.get('items', [])

    if not events:
        return "No Events Found"

    events = map(get_event_desc, events)
    return list(dict.fromkeys(events))

def write_list_file(events):
    # TODO: make dir if doesnt exist
    # TODO: make file if it doesnt exist
    # TODO: write file

def main():
    events = get_events()

    for event in events:
        print(event)

if __name__ == '__main__':
    main()
