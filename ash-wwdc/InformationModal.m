//
//  InformationModal.m
//  ash-wwdc
//
//  Created by Ash Bhat on 4/25/15.
//  Copyright (c) 2015 Ash Bhat. All rights reserved.
//

#import "InformationModal.h"
#import <UIKit/UIKit.h>
@implementation InformationModal


+(NSArray *)dictionaryForType:(DataType)dataType{
    NSArray *arrayOfData;
    
    switch (dataType) {
        case k_work:
            arrayOfData = [self workData];
            break;
        case k_education:
            arrayOfData = [self educationData];
            break;
        case k_projects:
            arrayOfData = [self projectData];
            break;
        default:
            break;
    }
    return arrayOfData;
}

+(NSArray *)workData{
    NSMutableArray *workData = [NSMutableArray new];
    NSMutableDictionary *OSB = [NSMutableDictionary new];
    
    OSB[@"title"] = @"Co-Founder @ 1StudentBody: \nJan 2014 - Now";
    OSB[@"image"] = [UIImage imageNamed:@"1sb"];
    OSB[@"description"] = @"I started 1StudentBody to continue what I had intially begun with iSchoolerz. I wanted to solve problems that I had as a high schooler through software and specifically iOS applications. We have awesome investors and an amazing team of 12 to accomplish this goal";
    OSB[@"url"] = @"http://1sb.com";
    [workData addObject:OSB];
    
    NSMutableDictionary *KIIP = [NSMutableDictionary new];
    
    KIIP[@"title"] = @"iOS Intern @ Kiip: \nSummer 2013";
    KIIP[@"image"] = [UIImage imageNamed:@"kiip"];
    KIIP[@"description"] = @"During the summer of 2013 I had the pleasure of being an iOS intern at Kiip Inc. Their SDK is integrated into thousands of iOS applications and delivers rewards, like giftcards and promo codes, to millions of peoples .";
    KIIP[@"url"] = @"http://kiip.com";

    [workData addObject:KIIP];
    
    NSMutableDictionary *ISCHOOLERZ = [NSMutableDictionary new];
    
    ISCHOOLERZ[@"title"] = @"CEO @ iSchoolerz: \n2011-2013";
    ISCHOOLERZ[@"image"] = [UIImage imageNamed:@"ischoolerz"];
    ISCHOOLERZ[@"description"] = @"I started iSchoolerz my freshman year of high school to bring applications to high schools. Initially I made these applications for free. I ended up turning iSchoolerz into a business and built apps for numerous schools in the bay area.";
    ISCHOOLERZ[@"url"] = @"http://ischoolerz.com";
    [workData addObject:ISCHOOLERZ];
    
    return workData;
}

+(NSArray *)educationData{
    NSMutableArray *educationData = [NSMutableArray new];
    NSMutableDictionary *Cal = [NSMutableDictionary new];
    
    Cal[@"title"] = @"UC Berkeley \nClass of 2019!";
    Cal[@"image"] = [UIImage imageNamed:@"cal-logo"];
    Cal[@"description"] = @"I'm incredibly excited to be studying Computer Science the coming year at UC Berkeley. I was admitted early 2015 as a candidate for their Regents Scholarship. I officially committed in April to go to the school.";
    Cal[@"url"] = @"http://www.berkeley.edu";
    [educationData addObject:Cal];
    
    NSMutableDictionary *FusionAcademy = [NSMutableDictionary new];
    
    FusionAcademy[@"title"] = @"Fusion Academy [current] \n11th - 12th grade";
    FusionAcademy[@"image"] = [UIImage imageNamed:@"fusion@2x"];
    FusionAcademy[@"description"] = @"I'm currently a Senior (12th grade) at Fusion Academy San Mateo. I left my public high school (Santa Teresa) to the one-on-one teaching of Fusion Academy which gives me the flexibility and schedule to work on my company (1StudentBody) and other iOS projects.";
    FusionAcademy[@"url"] = @"http://www.fusionacademy.com/";

    [educationData addObject:FusionAcademy];
    
    NSMutableDictionary *SantaTeresa = [NSMutableDictionary new];
    
    SantaTeresa[@"title"] = @"Santa Teresa HS \n9th - 11th grade";
    SantaTeresa[@"image"] = [UIImage imageNamed:@"st"];
    SantaTeresa[@"description"] = @"I attended Santa Teresa HS from my Freshman year (9th grade) to my Junior Year (11th grade). I was active in Model UN and served as President my junior year of high school. I also started a club to teach my peers iOS development. The club was called Hackers@ST.";
    SantaTeresa[@"url"] = @"http://santateresa.esuhsd.org";
    [educationData addObject:SantaTeresa];
    
    return educationData;
}

+(NSArray *)projectData{
    NSMutableArray *projectData = [NSMutableArray new];

    NSMutableDictionary *Sidechat = [NSMutableDictionary new];
    
    Sidechat[@"title"] = @"Sidechat\nGroup chats w/ your best friends";
    Sidechat[@"image"] = [UIImage imageNamed:@"sidechat"];
    Sidechat[@"description"] = @"Sidechat was built after over 100 interviews with high school students. Our team asked each student a simple question. \"What applications do you use multiple times each day but annoy you?\". We were surprised to hear that group messaging was a pain point and build a messaging app that tailored to the High School demographic.";
    Sidechat[@"url"] = @"https://itunes.apple.com/us/app/sidechat-fun-personal-group/id964672538?mt=8";
    [projectData addObject:Sidechat];
    
    NSMutableDictionary *Notesnap = [NSMutableDictionary new];
    
    Notesnap[@"title"] = @"Notesnap\nSnap and share notes.";
    Notesnap[@"image"] = [UIImage imageNamed:@"notesnap"];
    Notesnap[@"description"] = @"I built NoteSnap after noticing that I was taking a lot of picture of whiteboards in High School. I realized that it would be very valuable if I were able to crop, filter, and share these notes with my peers. Notesnap was built to do precisely that.";
    Notesnap[@"url"] = @"https://itunes.apple.com/us/app/notesnap-high-school-note/id865845672?mt=8";
    [projectData addObject:Notesnap];
    
    return projectData;
}

@end
