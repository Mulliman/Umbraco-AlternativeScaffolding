# Introduction

This uses the Scaffolding functionality provided by the NuGet package UmbracoCms.Scaffolding to create MVC components for Umbraco projects using a common convention.

These files are for conventions slightly different than the standard ones in UmbracoCms.Scaffolding.

## SurfaceControllers

An extra parameter is added to the SurfaceController scaffold to allow for grouping into folders.

    Scaffold SurfaceController {FeatureName} {FolderName} {comma,separated,properties} 

#### Directory structure

- Controllers
    - {FolderName}
- Models
    - {FolderName}
- Views
    - Partials
        - {FolderName}

#### File names

    {FeatureName}Controller 
    {FeatureName}Model 
    {FeatureName}View

#### Example

    Scaffold SurfaceController BlogListing Blog BlogArticles 

- Controllers
    - Blog
        - BlogListingController.cs
- Models
    - Blog
        - BlogListingModel.cs
- Views
    - Partials
        - Blog
            - BlogListingView.cshtml