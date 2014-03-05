# Dev Notes

## Clipping examples

```
So Good They Can't Ignore You: Why Skills Trump Passion in the Quest for Work You Love (Newport, Cal)
- Your Highlight on Location 97-98 | Added on Thursday, February 27, 2014 11:52:15 PM

When it comes to creating work you love, following your passion is not particularly useful advice.
==========
Rock Your Plot: A Simple System for Plotting Your Novel (Rock Your Writing) (Yardley, Cathy)
- Your Highlight Location 45-46 | Added on Friday, November 29, 2013 11:44:58 AM

While this process can work for any fiction that uses traditional three-act structure, this process works best for commercial genre fiction:
==========
```

Line 1 (publication data): title (subtitle? publisher?) (author)
Line 2 (annotation metadata): kind of annotation | created at timestamp - some variation in exact wording but "Highlight", "Location
Line 3 (blank - remove): BLANK
Line 4 (annotation content): content

## Object design

Annotation
  - location_start
  - location_end
  - created_at
  - content
  - annotation_type (or use actual types Highlight and Note)
  - publication_id

Publication
  - title:string
  - publisher:string for now
  - author:Author
  - has_many :annotations Annotation

Author
  - name

AuthorPublications (join model)

Author name always appears to be the last thing in parentheses on the title
line. Multiple authors are separated by semicolons, e.g. (Oliver Kiddle;Peter
Stephenson;Jerry Peek). In multi-author title lines, the names are (First Last),
but in most other title lines the author name is (Last, First Middle). The
presence of a comma indicates the order of the name, but it is still nearly
impossible to parse parts of a name without guessing. For example: "James Van
Riemsdyk", "Doe, Jo Ann Mavis". In these examples how would you know first,
last, middle? You pretty much don't. We'll need to rely on search to find author
names instead of parsing into constituent parts and listing them in alphabetical
order.

## Parsing

There's a ImportProcessor which acts as the imperative shell. The
ImportProcessor tells the FileParser to parse out raw clippings strings into a
collection. The ImportProcessor then hands each of those raw clippings to the
ClippingParser. The ClippingParser doesn't care about domain objects, but it
knows enough to format the data with meaningful keys, e.g. { publication_data: '',
annotation_metadata: '', annotation_content: '' }. This hash is effectively
config.

Given structured data about clippings, the ImportProcessor in turn instantiates
a Publication and an Annotation and hands them to a PublicationRepository to
persist the data. I don't think we'll need an AnnotationRepository. The
Publication is like an aggregate root in DDD speak. We go through Publications
to get Annotations.

There's a question of whether we should munge the data such that a sane data
structure is produced that consists of a single publication and many nested
annotations. This is probably a good idea since it would relieve the burden on
the repository to check over and over again for the existence of a publication.
It will still need to check, it will just more efficient to hand it a sanitized
data structure. There's no way we can know if the annotations themselves already
exist in the data store. Those will have to be checked one-by-one before being
persisted.

## Repository classes, data

We can stub the repository classes and make sure that the ImportProcessor calls
those classes with the correct data. The Repository classes in turn know about
their entity classes, which are simply Publication and Annotation. Entity
classes  should be tested separately.

The PublicationRepository is responsible for persisting publication entity data,
which includes associated annotations. It is also responsible for fetching data -
it responds to queries for data and returns entity objects.

The data is stored in a local, file-based datastore. A web app can access that
data. The web app may use the same domain objects as the importer. It may be
that the importer is kicked off via a command line app, as I had imagined, or
via a web app via a file upload.

## Annotation object

I'm not sure there's enough difference between Note and Highlight to warrant
separate classes, but they seem different enough in the real world to warrant
separate consideration. Perhaps start with inheritance? Annotation. Highlight <
Annotation. Note < Annotation. Once I know more I may change the design.

I can imagine that Notes and Highlights will be displayed differently, but at
the data level they only differ by their annotation_type. All behavior would be
inherited as would most of the data. I'm just not sure at this point. What I
read tells me to avoid inheritance until I know and that it's easier to push
behavior up then down.

## Other notes

I don’t care about bookmarks, ignore those.

Order by location. Important.
