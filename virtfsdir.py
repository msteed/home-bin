#!/usr/bin/env python

from cassandra.cluster import Cluster
from cassandra.auth import PlainTextAuthProvider

ROOTDIR_INODE_ID = 'a5e256a8-8aca-472f-95b9-655cc813e035'

def connect():
    auth_provider = PlainTextAuthProvider(username='cassandra', password='cassandra')
    cluster = Cluster(auth_provider=auth_provider)
    session = cluster.connect()
    session.execute('use raas_019008c20b7511e5b76c6c71d98')
    return session

def ls(session, uuid, indent=0):
    dirinfo = session.execute('select dirents from directory where "_id"={0}'.format(uuid))
    for k, v in dirinfo[0].dirents.items():
        (saltenv, name) = k.split('_|-')
        (rtype, uuid) = v.split('_|-')
        if name in ('.', '..'):
            continue
        print('{0:30s} {1}'.format(' ' * indent + name, rtype))
        if rtype == 'directory':
            ls(session, uuid, indent + 2)

if __name__ == '__main__':
    session = connect()
    ls(session, ROOTDIR_INODE_ID)
