# Nodes

Here I am using graph nodes to model the gtfs data. The models enforce the constraints of the GTFS spec where applicable. One deviation from the spec is that I decided to reduce redundancy by removing the model name as a prefix within the property name.  For example:

The GTFS spec has agencies with an
```
agency_name
```
where this is the case I have called the property simply
```
name
```
So that it can be called like
```
Node::Agency.where(name: 'MBTA')
```
Instead of, the more redundant
```
Node::Agency.where(agency_name: 'MBTA')
```
The only exception to this rule is the GTFS primary and foreign key.  Since the neo4j primary key is also named id and will be auto generated on insertion I have opted to leave any gtfs keys with there prefixed name, like
```
agency_id
```
